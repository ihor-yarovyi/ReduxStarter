//
//  AppFlow.swift
//  ReduxApp
//
//  Created by Ihor Yarovyi on 8/28/21.
//

import SwiftUI

enum AppFlow {
    case general(GeneralAppFlow)
    case verifyEmail(onVerify: @autoclosure () -> AnyView)
    case verifyRestoreToken(onVerify: @autoclosure () -> AnyView)
    case launchScreen(onLaunch: @autoclosure () -> AnyView)
    
    enum GeneralAppFlow {
        case auth(onAuth: @autoclosure () -> AnyView)
        case main(onMain: @autoclosure () -> AnyView)
    }
}
