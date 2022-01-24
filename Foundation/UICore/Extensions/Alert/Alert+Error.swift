//
//  Alert+Error.swift
//  UICore
//
//  Created by Ihor Yarovyi on 01.01.2022.
//

import SwiftUI
import Resources

public extension Alert {
    static func error(message: Text?, onDismiss: (() -> Void)? = nil) -> Alert {
        Alert(
            title: Text(Strings.Alert.Titles.error),
            message: message,
            dismissButton: .default(Text(Strings.Alert.Actions.ok), action: onDismiss)
        )
    }
}
