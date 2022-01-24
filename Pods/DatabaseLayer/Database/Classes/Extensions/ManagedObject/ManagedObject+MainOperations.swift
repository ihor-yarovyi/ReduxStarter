//
//  ManagedObject+MainOperations.swift
//  Database
//
//  Created by Ihor Yarovyi on 7/20/21.
//

import CoreData

public extension ManagedObject where Self: NSManagedObject {
    @discardableResult
    static func create(_ context: NSManagedObjectContext) -> Self {
        self.init(context: context)
    }

    func remove(_ context: NSManagedObjectContext) {
        context.delete(self)
    }

    // MARK: - First
    static func first(_ context: NSManagedObjectContext) -> Self? {
        let request = commonFetchRequest()
        request.fetchLimit = 1
        request.fetchBatchSize = 1

        do {
            let results = try context.fetch(request)
            return results.first
        } catch {
            debugPrint(error.localizedDescription)
        }

        return nil
    }

    static func first(_ predicate: NSPredicate, context: NSManagedObjectContext) -> Self? {
        let request = commonFetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1
        request.fetchBatchSize = 1

        do {
            let results = try context.fetch(request)
            return results.first
        } catch {
            debugPrint(error.localizedDescription)
        }

        return nil
    }

    // MARK: - Items
    static func items(_ fetchOffset: Int, fetchLimit: Int, context: NSManagedObjectContext) -> [Self] {
        let request = commonFetchRequest()
        request.fetchOffset = fetchOffset
        request.fetchLimit = fetchLimit

        do {
            let results = try context.fetch(request)
            return results
        } catch {
            debugPrint(error.localizedDescription)
        }

        return []
    }

    static func items(_ predicate: NSPredicate, context: NSManagedObjectContext) -> [Self] {
        items(predicate, fetchLimit: nil, context: context)
    }

    static func items(_ predicate: NSPredicate, fetchLimit: Int?, context: NSManagedObjectContext) -> [Self] {
        let request = commonFetchRequest()
        request.predicate = predicate
        fetchLimit.map { request.fetchLimit = $0 }

        do {
            let results = try context.fetch(request)
            return results
        } catch {
            debugPrint(error.localizedDescription)
        }

        return []
    }

    // MARK: - All
    static func all(_ context: NSManagedObjectContext) -> [Self] {
        let request = commonFetchRequest()

        do {
            let results = try context.fetch(request)
            return results
        } catch {
            debugPrint(error.localizedDescription)
        }

        return []
    }

    static func all(_ predicate: NSPredicate, context: NSManagedObjectContext) -> [Self] {
        let request = commonFetchRequest()
        request.predicate = predicate

        do {
            let results = try context.fetch(request)
            return results
        } catch {
            debugPrint(error.localizedDescription)
        }

        return []
    }
}

// MARK: - Private
private extension ManagedObject where Self: NSManagedObject {
    private static func commonFetchRequest() -> NSFetchRequest<Self> {
        guard let entityName = entity().name else {
            assertionFailure("entityName should be not nil")
            return NSFetchRequest<Self>()
        }

        let request = NSFetchRequest<Self>(entityName: entityName)
        return request
    }
}
