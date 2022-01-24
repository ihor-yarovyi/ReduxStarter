//
//  StoreProvider.swift
//  Redux
//
//  Created by Ihor Yarovyi on 8/15/21.
//

import SwiftUI
import Core
import UICore

public struct StoreProvider<Content: View>: View {
    let store: Store
    let content: () -> Content
    
    public init(store: Store, content: @escaping () -> Content) {
        self.store = store
        self.content = content
    }
    
    public var body: some View {
        content()
            .environmentObject(EnvironmentStore(store: store))
            .environmentObject(RouteManager())
    }
}
