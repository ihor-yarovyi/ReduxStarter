//
//  Utils.DeepLink+Kind.swift
//  Utils
//
//  Created by Ihor Yarovyi on 9/30/21.
//

import Foundation

public extension Utils.DeepLink {
    enum Kind {
        case verifiedEmail(token: String)
        case restorePassword(token: String)
    }
}
