//
//  ManagedObject+BatchOperations.swift
//  Database
//
//  Created by Ihor Yarovyi on 7/20/21.
//

import CoreData

public extension ManagedObject where Self: NSManagedObject {
    @discardableResult
    static func batchInsertAndMergeChanges<T>(models: T,
                                              onContext: NSManagedObjectContext,
                                              mergeTo: [NSManagedObjectContext]) -> [NSManagedObjectID] where T: Encodable {
        do {
            let data = try JSONEncoder().encode(models)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)

            guard let objects = jsonObject as? [[String: Any]] else {
                debugPrint("Failed to cast json object to dictionary")
                return []
            }
            guard !objects.isEmpty else { return [] }

            let request = NSBatchInsertRequest(entity: entity(), objects: objects)
            request.resultType = .objectIDs

            let result = try onContext.execute(request) as? NSBatchInsertResult
            let objectIDs = result?.result as? [NSManagedObjectID]
            let changes = [NSInsertedObjectsKey: objectIDs as Any]

            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: mergeTo)

            return objectIDs ?? []
        } catch {
            debugPrint("Failed to insert models with error \(error.localizedDescription)")
            return []
        }
    }

    static func batchDeleteAndMergeChanges(_ onContext: NSManagedObjectContext, mergeTo: [NSManagedObjectContext]) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        if let entityName = entity().name {
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        } else {
            assertionFailure("entityName should be not nil")
            fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        }

        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs

        do {
            let result = try onContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
            let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]

            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: mergeTo)
        } catch {
            debugPrint("Batch delete request failed with error \(error.localizedDescription)")
        }
    }

    static func batchDeleteAndMergeChanges(_ objectIDs: [NSManagedObjectID],
                                           onContext: NSManagedObjectContext,
                                           mergeTo: [NSManagedObjectContext]) {
        guard !objectIDs.isEmpty else { return }

        let batchDeleteRequest = NSBatchDeleteRequest(objectIDs: objectIDs)
        batchDeleteRequest.resultType = .resultTypeObjectIDs

        do {
            let result = try onContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
            let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]

            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: mergeTo)
        } catch {
            debugPrint("Batch delete request failed with error \(error.localizedDescription)")
        }
    }
}
