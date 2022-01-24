//
//  LoadingView.swift
//  SignIn
//
//  Created by Ihor Yarovyi on 8/15/21.
//

import SwiftUI

public struct LoadingView: ViewModifier {
    public var isLoading: Bool
    
    public func body(content: Content) -> some View {
        content
            .overlay(loader())
    }
}

private extension LoadingView {
    func loader() -> some View {
        Group {
            if isLoading {
                ZStack {
                    Color.black.opacity(0.2).ignoresSafeArea()
                    ProgressView()
                }
            }
        }
    }
}

public extension View {
    func isLoading(_ condition: Bool) -> some View {
        modifier(LoadingView(isLoading: condition))
    }
}
