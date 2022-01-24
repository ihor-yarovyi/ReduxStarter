//
//  LeftAligned.swift
//  UICore
//
//  Created by Ihor Yarovyi on 8/14/21.
//

import SwiftUI

public struct LeftAligned: ViewModifier {
    public func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
        }
    }
}

public extension View {
    func leftAligned() -> some View {
        modifier(LeftAligned())
    }
}
