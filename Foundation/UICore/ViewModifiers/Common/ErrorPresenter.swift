//
//  ErrorPresenter.swift
//  UICore
//
//  Created by Ihor Yarovyi on 8/19/21.
//

import SwiftUI
import Resources

public struct ErrorPresenter: ViewModifier {
    @Binding var isPresented: Bool
    let message: Text?
    let onDismiss: (() -> Void)?
    
    public func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented, content: {
                Alert.error(message: message, onDismiss: onDismiss)
            })
    }
}

public extension View {
    func errorAlert(isPresented: Binding<Bool>, with errorMessage: Text?, onDismiss: (() -> Void)? = {}) -> some View {
        modifier(ErrorPresenter(isPresented: isPresented, message: errorMessage, onDismiss: onDismiss))
    }
}
