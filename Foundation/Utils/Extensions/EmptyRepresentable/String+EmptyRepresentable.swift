//
//  String+EmptyRepresentable.swift
//  Utils
//
//  Created by Ihor Yarovyi on 10/10/21.
//

import Foundation

extension String: EmptyRepresentable {
    public static var empty: String { "" }
}
