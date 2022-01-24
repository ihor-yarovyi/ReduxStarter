//
//  NSManagedObjectContext+SaveChanges.swift
//  Database
//
//  Created by Ihor Yarovyi on 7/20/21.
//

import CoreData

public extension NSManagedObjectContext {
    func saveChanges(completion: ((Result<Void, Error>) -> Void)?) {
        if hasChanges {
            do {
                try save()
                performAsyncResult(result: .success(()), in: completion)
            } catch {
                debugPrint("Failed to save changes in context with error: \(error.localizedDescription)")
                performAsyncResult(result: .failure(error), in: completion)
                return
            }
        } else {
            performAsyncResult(result: .success(()), in: completion)
        }
    }
    
    func saveIfNeeded() throws {
        guard hasChanges else { return }
        try save()
    }
    
    private func performAsyncResult(result: Result<Void, Error>, in completion: ((Result<Void, Error>) -> Void)?) {
        DispatchQueue.main.async {
            completion?(result)
        }
    }
}
