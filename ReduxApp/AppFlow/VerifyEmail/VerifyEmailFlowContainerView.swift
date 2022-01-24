//
//  VerifyEmailFlowContainerView.swift
//  ReduxApp
//
//  Created by Ihor Yarovyi on 10/6/21.
//

import SwiftUI
import Redux

// An example how to launch new specific flow

/*
import SignIn
import SignUp
import Core

struct VerifyEmailFlowContainerView: View {
    let rootView: () -> AnyView
    let resultView: () -> AnyView
    var isActive: Binding<Bool>
    
    init(rootView: @escaping @autoclosure () -> AnyView,
         resultView: @escaping @autoclosure () -> AnyView,
         isActive: Binding<Bool>) {
        self.rootView = rootView
        self.resultView = resultView
        self.isActive = isActive
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                rootView()
                NavigationLink(
                    destination: resultView(),
                    isActive: isActive,
                    label: {
                        EmptyView()
                    }
                ).isDetailLink(false)
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct VerifyEmailConnector: Connector {
    func map(graph: Graph) -> some View {
        VerifyEmailFlowContainerView(
            rootView: SignIn.Connector().eraseToAnyView(),
            resultView: SignUp.EmailVerificationStatus.Connector().eraseToAnyView(),
            isActive: graph.signUpForm.isActive
        )
    }
}

private extension SignUpFormNode {
    var isActive: Binding<Bool> {
        switch emailVerificationProgress {
        case .none, .inProgress:
            return .constant(false)
        case .success, .failed:
            return .constant(true)
        }
    }
}
*/
