//
//  
//  LaunchScreen+Connector.swift
//  LaunchScreen
//
//  Created by Ihor Yarovyi on 9/5/21.
//
//

import SwiftUI
import Redux
import Core

public extension LaunchScreen {
    struct Connector: Redux.Connector {
        public init() {}

        public func map(graph: Graph) -> some View {
            MainView()
        }
    }
}
