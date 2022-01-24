//
//  RouteManager.swift
//  UICore
//
//  Created by Ihor Yarovyi on 1/3/22.
//

import SwiftUI

public final class RouteManager: ObservableObject {
    @Published
    private var routers: [Int: Route] = [:]
    
    public subscript(for route: Route) -> Route? {
        get {
            routers[route.rawValue]
        }
        set {
            routers[route.rawValue] = route
        }
    }
    
    public func select(_ route: Route) {
        routers[route.rawValue] = route
    }
    
    public func unselect(_ route: Route) {
        routers[route.rawValue] = nil
    }
    
    public init() {}
}
