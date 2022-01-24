//
//  Operator.swift
//  Database
//
//  Created by Ihor Yarovyi on 7/17/21.
//

import CoreData

public extension Database {
    class Operator {
        
        private let coreDataStack: CoreDataStackProtocol
        
        public var mainContext: NSManagedObjectContext {
            coreDataStack.mainContext
        }
        
        init(coreDataStack: CoreDataStackProtocol) {
            self.coreDataStack = coreDataStack
        }
    }
}

// MARK: - WriteProtocol

extension Database.Operator: WriteProtocol {
    @discardableResult
    public func writeSync(_ changes: @escaping ChangesBlock) -> Self {
        writeSync(changes, completion: nil)
    }
    
    @discardableResult
    public func writeSync(_ changes: @escaping ChangesBlock, completion: CompletionBlock?) -> Self {
        let context = coreDataStack.backgroundContext
        context.performAndWait {
            changes(context)
            context.saveChanges(completion: completion)
        }

        return self
    }
    
    public func writeAsync(_ changes: @escaping ChangesBlock) {
        writeAsync(changes, completion: nil)
    }
    
    public func writeAsync(_ changes: @escaping ChangesBlock, completion: CompletionBlock?) {
        let context = coreDataStack.backgroundContext
        context.perform {
            changes(context)
            context.saveChanges(completion: completion)
        }
    }
}

// MARK: - ReadProtocol

extension Database.Operator: ReadProtocol {
    @discardableResult
    public func mainReadSync(_ statements: @escaping StatementBlock) -> Self {
        let context = coreDataStack.mainContext
        context.performAndWait {
            statements(context)
        }

        return self
    }
    
    @discardableResult
    public func backgroundReadSync(_ statements: @escaping StatementBlock) -> Self {
        let context = coreDataStack.backgroundContext
        context.performAndWait {
            statements(context)
        }

        return self
    }
}
