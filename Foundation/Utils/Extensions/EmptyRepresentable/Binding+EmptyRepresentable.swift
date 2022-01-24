//
//  Binding+EmptyRepresentable.swift
//  Utils
//
//  Created by Ihor Yarovyi on 10/10/21.
//

import SwiftUI

extension Binding: EmptyRepresentable where Value: EmptyRepresentable {
    public static var empty: Binding<Value> {
        .constant(Value.empty)
    }
}
