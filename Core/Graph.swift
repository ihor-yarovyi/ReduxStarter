//
//  Graph.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/14/21.
//

import Foundation

public struct Graph {
    public init(state: AppState, dispatch: @escaping (Action) -> ()) {
        self.state = state
        self.dispatch = dispatch
    }
    
    let state: AppState
    let dispatch: (Action) -> ()
}
