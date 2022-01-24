//
//  WriteProtocol.swift
//  Database
//
//  Created by Ihor Yarovyi on 7/20/21.
//

import CoreData

public protocol WriteProtocol {
    typealias ChangesBlock = (NSManagedObjectContext) -> Void
    typealias CompletionBlock = ((Result<Void, Error>) -> Void)

    @discardableResult
    func writeSync(_ changes: @escaping ChangesBlock) -> Self
    @discardableResult
    func writeSync(_ changes: @escaping ChangesBlock, completion: CompletionBlock?) -> Self

    func writeAsync(_ changes: @escaping ChangesBlock)
    func writeAsync(_ changes: @escaping ChangesBlock, completion: CompletionBlock?)
}
