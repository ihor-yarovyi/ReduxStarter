//
//  Text+EmptyRepresentable.swift
//  Utils
//
//  Created by Ihor Yarovyi on 10/10/21.
//

import SwiftUI

extension Text: EmptyRepresentable {
    public static var empty: Text {
        Text(String.empty)
    }
}
