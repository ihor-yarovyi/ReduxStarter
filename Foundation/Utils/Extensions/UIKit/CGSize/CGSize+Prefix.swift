//
//  CGSize+Prefix.swift
//  Utils
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import UIKit

public extension CGSize {
    var prefix: String {
        "\(Int(width))x\(Int(height))"
    }
}
