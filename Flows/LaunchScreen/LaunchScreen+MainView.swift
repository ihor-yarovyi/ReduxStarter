//
//  
//  LaunchScreen+MainView.swift
//  LaunchScreen
//
//  Created by Ihor Yarovyi on 9/5/21.
//
//

import SwiftUI
import Resources
import UICore

public extension LaunchScreen {
    struct MainView: View {

        public var body: some View {
            ZStack {
                Color.white
                logo()
            }.isLoading(true)
        }
    }
}

// MARK: - Private Views
private extension LaunchScreen.MainView {
    func logo() -> some View {
        Image(Asset.templateIcon.name)
            .frame(minWidth: Defaults.Logo.width,
                   minHeight: Defaults.Logo.height,
                   alignment: .center)
    }
}

// MARK: - Defaults
private extension LaunchScreen.MainView {
    enum Defaults {
        enum Logo {
            static let height: CGFloat = 200
            static let width: CGFloat = 200
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen.MainView()
    }
}
