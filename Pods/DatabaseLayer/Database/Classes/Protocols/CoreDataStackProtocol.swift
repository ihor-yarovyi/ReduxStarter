//
//  CoreDataStackProtocol.swift
//  Database
//
//  Created by Ihor Yarovyi on 7/18/21.
//

import CoreData

protocol CoreDataStackProtocol {
    var mainContext: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }
}
