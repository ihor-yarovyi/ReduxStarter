//
//  CDUser+CoreDataProperties.swift
//  DatabaseClient
//
//  Created by Ihor Yarovyi on 8/28/21.
//
//

import CoreData

public extension DatabaseClient.Models.CDUser {
    @nonobjc class func fetchRequest() -> NSFetchRequest<DatabaseClient.Models.CDUser> {
        NSFetchRequest<DatabaseClient.Models.CDUser>(entityName: String(describing: DatabaseClient.Models.CDUser.self))
    }

    @NSManaged var id: Int64
    @NSManaged var createdAt: String
    @NSManaged var updatedAt: String
    @NSManaged var email: String?
    @NSManaged var username: String
}

extension DatabaseClient.Models.CDUser: Identifiable {}
