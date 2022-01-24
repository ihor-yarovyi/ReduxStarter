//
//  Connector.swift
//  Redux
//
//  Created by Ihor Yarovyi on 8/15/21.
//

import SwiftUI
import Core

public protocol Connector: View {
    associatedtype Content: View
    func map(graph: Graph) -> Content
}

public extension Connector {
    var body: some View {
        Connected<Content>(map: self.map)
    }
}

private struct Connected<V: View>: View {
    @EnvironmentObject var store: EnvironmentStore
    let map: (Graph) -> V
    
    var body: V {
        map(store.graph)
    }
}
