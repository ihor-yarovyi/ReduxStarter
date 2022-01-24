//
//  AppFlowView.swift
//  ReduxApp
//
//  Created by Ihor Yarovyi on 10/5/21.
//

import SwiftUI
import Redux

struct AppFlowView: View {
    let flow: AppFlow
    
    var body: some View {
        ZStack {
            switch flow {
            case let .verifyEmail(verifyEmail):
                verifyEmail()
            case let .verifyRestoreToken(verifyToken):
                verifyToken()
            case let .launchScreen(launchScreen):
                launchScreen()
            case let .general(flow):
                switch flow {
                case let .auth(signIn):
                    signIn()
                case let .main(main):
                    main()
                }
            }
        }
    }
}

struct AppFlowConnector: Connector {
    func map(graph: Graph) -> some View {
        AppFlowView(flow: AppFlowBuilder.make(basedOn: graph))
    }
}
