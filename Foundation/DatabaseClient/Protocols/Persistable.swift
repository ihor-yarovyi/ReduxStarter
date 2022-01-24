//
//  Persistable.swift
//  DatabaseClient
//
//  Created by Ihor Yarovyi on 8/28/21.
//

import CoreData

public protocol Persistable {
    associatedtype Object: NSManagedObject
    
    func update(_ object: Object)
}
