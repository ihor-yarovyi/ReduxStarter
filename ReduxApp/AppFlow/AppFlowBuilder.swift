//
//  AppFlowBuilder.swift
//  ReduxApp
//
//  Created by Ihor Yarovyi on 1/4/22.
//

import SwiftUI
import Redux
/*
import SignIn
 */
import LaunchScreen

struct AppFlowBuilder {
    static func make(basedOn graph: Graph) -> AppFlow {
        /*
        if graph.session.hasSessionResult {
            if graph.session.isActive {
                return .general(.main(onMain: EmptyView().eraseToAnyView()))
            } else {
                if graph.deepLink.isActive {
                    if graph.signUpForm.hasVerificationResult {
                        return .verifyEmail(onVerify: VerifyEmailConnector().eraseToAnyView())
                    } else if graph.restorePassword.hasVerificationResult {
                        return .verifyRestoreToken(onVerify: VerifyRestoreTokenConnector().eraseToAnyView())
                    }
                } else {
                    return .general(.auth(onAuth: SignIn.Connector().eraseToAnyView()))
                }
            }
        }
         */
        
        return .launchScreen(onLaunch: LaunchScreen.Connector().eraseToAnyView())
    }
}
