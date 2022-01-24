//
//  Store.swift
//  Redux
//
//  Created by Ihor Yarovyi on 8/15/21.
//

import SwiftUI

public final class EnvironmentStore: ObservableObject {
    @Published private(set) var graph: Graph
    let store: Store
    
    public init(store: Store) {
        self.store = store
        graph = Graph(state: store.state, dispatch: store.dispatch(action:))
        store.subscribe(observer: asObserver)
    }
    
    private var asObserver: Observer {
        Observer(queue: .main) { [unowned self] state in
            graph = Graph(state: state, dispatch: store.dispatch(action:))
            return .active
        }
    }
}
