//
//  Executor.swift
//  DatabaseLayer
//
//  Created by Ihor Yarovyi on 8/28/21.
//

import CoreData

public extension Database {
    final class Executor {
        public static let shared = Executor()
        private init() {}
    }
}

// MARK: - Batch Operations
public extension Database.Executor {
    func batchInsertAndMergeChanges<Input, Output>(
        models: Input,
        to entity: Output.Type,
        onContext context: NSManagedObjectContext,
        mergeTo: [NSManagedObjectContext]
    ) throws -> [NSManagedObjectID]
    where Input: Encodable, Output: NSManagedObject {
        let data = try JSONEncoder().encode(models)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        guard let objects = jsonObject as? [[String: Any]], !objects.isEmpty else { return [] }
        
        let request = NSBatchInsertRequest(entity: entity.entity(), objects: objects)
        request.resultType = .objectIDs

        let result = try context.execute(request) as? NSBatchInsertResult
        let objectIDs = result?.result as? [NSManagedObjectID]
        let changes = [NSInsertedObjectsKey: objectIDs as Any]

        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: mergeTo)

        return objectIDs ?? []
    }
    
    func batchDeleteAndMergeChanges<Entity>(
        _ entity: Entity.Type,
        predicate: NSPredicate? = nil,
        onContext context: NSManagedObjectContext,
        mergeTo: [NSManagedObjectContext]
    ) throws where Entity: NSManagedObject {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        if let entityName = entity.entity().name {
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fetchRequest.predicate = predicate
        } else {
            assertionFailure("entityName should be not nil")
            fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        }

        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        let result = try context.execute(batchDeleteRequest) as? NSBatchDeleteResult
        let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]

        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: mergeTo)
    }
    
    func batchDeleteAndMergeChanges(
        _ objectIDs: [NSManagedObjectID],
        onContext context: NSManagedObjectContext,
        mergeTo: [NSManagedObjectContext]
    ) throws {
        guard !objectIDs.isEmpty else { return }

        let batchDeleteRequest = NSBatchDeleteRequest(objectIDs: objectIDs)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        let result = try context.execute(batchDeleteRequest) as? NSBatchDeleteResult
        let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]

        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: mergeTo)
    }
}

// MARK: - Main Operations: Create
public extension Database.Executor {
    @discardableResult
    func create<Entity>(_ entity: Entity.Type, context: NSManagedObjectContext) -> Entity where Entity: NSManagedObject {
        entity.init(context: context)
    }
}

// MARK: - Main Operations: Delete
public extension Database.Executor {
    func remove<Entity>(_ entity: Entity, context: NSManagedObjectContext) where Entity: NSManagedObject {
        context.delete(entity)
    }
}

// MARK: - Main Operations: Read
public extension Database.Executor {
    func first<Entity>(
        _ entity: Entity.Type,
        predicate: NSPredicate? = nil,
        context: NSManagedObjectContext
    ) throws -> Entity? where Entity: NSManagedObject {
        let request = commonFetchRequest(for: entity)
        request.predicate = predicate
        request.fetchLimit = 1
        request.fetchBatchSize = 1
        return try context.fetch(request).first
    }
    
    func items<Entity>(
        _ entity: Entity.Type,
        offset: Int,
        limit: Int,
        context: NSManagedObjectContext
    ) throws -> [Entity] where Entity: NSManagedObject {
        let request = commonFetchRequest(for: entity)
        request.fetchOffset = offset
        request.fetchLimit = limit
        return try context.fetch(request)
    }
    
    func items<Entity>(
        _ entity: Entity.Type,
        predicate: NSPredicate,
        fetchLimit: Int?,
        context: NSManagedObjectContext
    ) throws -> [Entity] where Entity: NSManagedObject {
        let request = commonFetchRequest(for: entity)
        request.predicate = predicate
        fetchLimit.map { request.fetchLimit = $0 }
        return try context.fetch(request)
    }
    
    func items<Entity>(
        _ entity: Entity.Type,
        predicate: NSPredicate,
        context: NSManagedObjectContext
    ) throws -> [Entity] where Entity: NSManagedObject {
        try items(entity, predicate: predicate, fetchLimit: nil, context: context)
    }
    
    func all<Entity>(
        _ entity: Entity.Type,
        context: NSManagedObjectContext
    ) throws -> [Entity] where Entity: NSManagedObject {
        let request = commonFetchRequest(for: entity)
        return try context.fetch(request)
    }
    
    func all<Entity>(
        _ entity: Entity.Type,
        predicate: NSPredicate,
        context: NSManagedObjectContext
    ) throws -> [Entity] where Entity: NSManagedObject {
        let request = commonFetchRequest(for: entity)
        request.predicate = predicate
        return try context.fetch(request)
    }
}

// MARK: - Common Fetch Request
private extension Database.Executor {
    func commonFetchRequest<Entity>(for entity: Entity.Type) -> NSFetchRequest<Entity> where Entity: NSManagedObject {
        guard let entityName = entity.entity().name else {
            assertionFailure("entityName should be not nil")
            return NSFetchRequest<Entity>()
        }

        return NSFetchRequest<Entity>(entityName: entityName)
    }
}
