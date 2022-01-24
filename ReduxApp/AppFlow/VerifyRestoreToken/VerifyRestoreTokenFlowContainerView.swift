//
//  VerifyRestoreTokenFlowContainerView.swift
//  ReduxApp
//
//  Created by Ihor Yarovyi on 1/3/22.
//

import SwiftUI
import Redux

// An example how to launch new specific flow 

/*
import SignIn
import RestorePassword
import LaunchScreen
import Core

struct VerifyRestoreTokenFlowContainerView: View {
    let rootView: () -> AnyView
    let loadingView: () -> AnyView
    let destinationView: () -> AnyView
    let isActive: Binding<Bool>
    let isErrorOccur: Binding<Bool>
    let error: Error?
    
    init(rootView: @escaping @autoclosure () -> AnyView,
         loadingView: @escaping @autoclosure () -> AnyView,
         destinationView: @escaping @autoclosure () -> AnyView,
         isActive: Binding<Bool>,
         isErrorOccur: Binding<Bool>,
         error: Error?) {
        self.rootView = rootView
        self.loadingView = loadingView
        self.destinationView = destinationView
        self.isActive = isActive
        self.isErrorOccur = isErrorOccur
        self.error = error
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                rootView()
                
                NavigationLink(
                    isActive: isActive,
                    destination: { destinationView() },
                    label: {
                        EmptyView()
                    }
                ).isDetailLink(false)
            }
            .errorAlert(
                isPresented: isErrorOccur,
                with: error.flatMap { Text($0.localizedDescription) }
            )
        }
        .navigationBarHidden(true)
        .navigationViewStyle(.stack)
    }
}

struct VerifyRestoreTokenConnector: Connector {
    func map(graph: Graph) -> some View {
        VerifyRestoreTokenFlowContainerView(
            rootView: SignIn.Connector().eraseToAnyView(),
            loadingView: LaunchScreen.Connector().eraseToAnyView(),
            destinationView: RestorePassword.NewPasswordView.Connector().eraseToAnyView(),
            isActive: graph.restorePassword.isActive,
            isErrorOccur: graph.restorePassword.isErrorOccur,
            error: graph.restorePassword.error
        )
    }
}

private extension RestorePasswordNode {
    var isActive: Binding<Bool> {
        switch restoreTokenVerificationProgress {
        case .success:
            return .constant(true)
        case .none, .inProgress, .failed:
            return .constant(false)
        }
    }
    
    var isErrorOccur: Binding<Bool> {
        switch restoreTokenVerificationProgress {
        case .failed:
            return .constant(true)
        case .inProgress, .none, .success:
            return .constant(false)
        }
    }
    
    var error: Error? {
        switch restoreTokenVerificationProgress {
        case let .failed(error):
            return error
        case .none, .inProgress, .success:
            return nil
        }
    }
}
 */
