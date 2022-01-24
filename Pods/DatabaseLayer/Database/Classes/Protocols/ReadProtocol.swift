//
//  ReadProtocol.swift
//  Database
//
//  Created by Ihor Yarovyi on 7/20/21.
//

import CoreData

public protocol ReadProtocol {
    typealias StatementBlock = (NSManagedObjectContext) -> Void

    @discardableResult
    func mainReadSync(_ statements: @escaping StatementBlock) -> Self

    @discardableResult
    func backgroundReadSync(_ statements: @escaping StatementBlock) -> Self
}
