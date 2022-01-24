//
//  BaseCoreDataStack.swift
//  Database
//
//  Created by Ihor Yarovyi on 7/18/21.
//

import CoreData

extension Database {
    class BaseCoreDataStack: CoreDataStackProtocol {
        let modelName: String
        let modelURL: URL?
        
        private(set) lazy var container: NSPersistentContainer = {
            guard let modelURL = modelURL, let mom = NSManagedObjectModel(contentsOf: modelURL) else {
                return NSPersistentContainer(name: modelName)
            }
            return NSPersistentContainer(name: modelName, managedObjectModel: mom)
        }()
        
        // MARK: - Lifecycle
        
        init(modelName: String, modelURL: URL?, completion: ((Error?) -> Void)? = nil) {
            self.modelName = modelName
            self.modelURL = modelURL
            setup(with: completion)
        }
        
        // MARK: - CoreDataProtocol
        
        lazy var mainContext: NSManagedObjectContext = {
            let context = container.viewContext
            context.setup()
            return context
        }()
        
        var backgroundContext: NSManagedObjectContext {
            let context = container.newBackgroundContext()
            context.setup()
            return context
        }
        
        // MARK: - Setup
        
        func setup(with completion: ((Error?) -> Void)?) {
            // Should be overriden in the child class
            assertionFailure("You should not use a base class")
        }
    }
}
