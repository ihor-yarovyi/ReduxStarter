//
//  DatabaseClient+Instance.swift
//  DatabaseClient
//
//  Created by Ihor Yarovyi on 8/28/21.
//

import CoreData
import DatabaseLayer
import PredicateKit

public extension DatabaseClient {
    final class Instance {
        // MARK: - Properties
        private let database: Database.Operator
        private let executor = Database.Executor.shared
        private static var modelURL: URL? {
            Bundle(for: self).url(
                forResource: Database.Instance.modelName,
                withExtension: "momd"
            )
        }
        
        // MARK: - Lifecycle
        private init(database: Database.Operator) {
            self.database = database
        }
        
        public static func sqlInstance() -> Instance {
            .init(database: Database.Instance.sqliteInstance(modelURL: modelURL))
        }
        
        public static func inMemoryInstance() -> Instance {
            .init(database: Database.Instance.inMemoryInstance(modelURL: modelURL))
        }
    }
}

// MARK: - CRUD
public extension DatabaseClient.Instance {
    func create<Entity>(
        from entity: Entity,
        completion: @escaping (Result<Void, Error>) -> Void
    ) where Entity: Persistable {
        database.writeAsync({ [unowned self] context in
            let dbEntity = executor.create(Entity.Object.self, context: context)
            entity.update(dbEntity)
        }, completion: completion)
    }
    
    func create<Input>(
        from inputs: Input,
        completion: @escaping (Result<Void, Error>) -> Void
    ) where Input: Encodable & Persistable {
        database.writeAsync { [unowned self] context in
            do {
                _ = try executor.batchInsertAndMergeChanges(
                    models: inputs,
                    to: Input.Object.self,
                    onContext: context,
                    mergeTo: [context, database.mainContext]
                )
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func contains<Entity>(
        _ entity: Entity.Type,
        where predicate: @escaping () -> Predicate<Entity.Object>,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) where Entity: Persistable {
        database.backgroundReadSync { context in
            do {
                let result: Entity.Object? = try context.fetch(where: predicate()).result().first
                completion(.success(result != nil))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

// MARK: - ProviderProtocol
extension DatabaseClient.Instance: ProviderProtocol {
    public var storageOperator: Database.Operator {
        database
    }
    
    public func configure() {
        // empty implementation
    }
    
    public func removeData<Model>(_ data: [Model.Type]) where Model: NSManagedObject {
        storageOperator.writeAsync { [unowned self] context in
            data.forEach { entity in
                try? executor.batchDeleteAndMergeChanges(
                    entity,
                    onContext: context,
                    mergeTo: [context, storageOperator.mainContext]
                )
            }
        }
    }
}
