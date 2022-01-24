//
//  ProviderProtocol.swift
//  Database
//
//  Created by Ihor Yarovyi on 7/20/21.
//

import CoreData

public protocol ProviderProtocol {
    var storageOperator: Database.Operator { get }
    func configure()
    func removeData<Model: ManagedObject & NSManagedObject>(_ data: [Model.Type])
}
