//
//  View+EraseToAnyView.swift
//  UICore
//
//  Created by Ihor Yarovyi on 9/12/21.
//

import SwiftUI

public extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
