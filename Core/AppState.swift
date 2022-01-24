//
//  AppState.swift
//  Core
//
//  Created by Ihor Yarovyi on 8/14/21.
//

import Foundation

public struct AppState {
    /**
        Init state like:
        `public var loginForm = LoginForm()`
    */
    
    public mutating func reduce(_ action: Action) {
        /**
            Reduce action like:
            `loginForm.reduce(action)`
        */
    }
    
    public init() {}
}
