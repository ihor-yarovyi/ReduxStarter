//
//  NSManagedObjectContext+Setup.swift
//  Database
//
//  Created by Ihor Yarovyi on 7/18/21.
//

import CoreData

extension NSManagedObjectContext {
    func setup() {
        mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        shouldDeleteInaccessibleFaults = true
        automaticallyMergesChangesFromParent = true
    }
}
