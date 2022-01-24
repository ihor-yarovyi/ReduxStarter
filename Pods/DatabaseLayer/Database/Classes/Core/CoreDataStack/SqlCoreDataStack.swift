//
//  SqlCoreDataStack.swift
//  Database
//
//  Created by Ihor Yarovyi on 7/18/21.
//

import CoreData

extension Database {
    final class SqlCoreDataStack: BaseCoreDataStack {
        override func setup(with completion: ((Error?) -> Void)?) {
            let url = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent(modelName)
            let description = NSPersistentStoreDescription(url: url)
            description.type = NSSQLiteStoreType
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { _, error in
                completion?(error)
            }
        }
    }
}
