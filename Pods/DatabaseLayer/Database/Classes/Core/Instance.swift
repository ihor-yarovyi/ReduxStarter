//
//  Instance.swift
//  Database
//
//  Created by Ihor Yarovyi on 7/20/21.
//

import Foundation

public extension Database {
    final class Instance: Operator {
        public static var modelName = "DataModel"
        
        public static func sqliteInstance(modelName: String = modelName, modelURL: URL?) -> Operator {
            Instance(sqliteModelName: modelName, modelURL: modelURL)
        }
        
        public static func inMemoryInstance(modelName: String = modelName, modelURL: URL?) -> Operator {
            Instance(inMemoryModelName: modelName, modelURL: modelURL)
        }
        
        convenience init(sqliteModelName: String,
                         modelURL: URL?,
                         completion: ((Error?) -> Void)? = nil) {
            let coreData = SqlCoreDataStack(modelName: sqliteModelName,
                                            modelURL: modelURL,
                                            completion: completion)
            self.init(coreDataStack: coreData)
        }
        
        convenience init(inMemoryModelName: String,
                         modelURL: URL?,
                         completion: ((Error?) -> Void)? = nil) {
            let coreData = InMemoryCoreDataStack(modelName: inMemoryModelName,
                                                 modelURL: modelURL,
                                                 completion: completion)
            self.init(coreDataStack: coreData)
        }
    }
}
