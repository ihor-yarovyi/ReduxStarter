//
//  ReduxApp.swift
//  ReduxApp
//
//  Created by Ihor Yarovyi on 7/24/21.
//

import SwiftUI
import Redux
import SideEffects
import DatabaseClient
import EnvConfig
import Core
import Utils

@main
struct ReduxApp: App {
    
    private let store = Store(initial: AppState()) { state, action in
        print("Reduce\t\t\t", action)
        state.reduce(action)
    }
    
    private let databaseClient: DatabaseClient.Instance = DatabaseClient.Instance.sqlInstance()
    
    /*
     private let signInSE: SideEffects.SignIn
     */
    
    init() {
        /*
        signInSE = SideEffects.SignIn(store: store, databaseClient: databaseClient)
         
         store.subscribe(observer: signInSE.asObserver)
         */
    }
    
    var body: some Scene {
        WindowGroup {
            StoreProvider(store: store) {
                AppFlowConnector()
            }
        }
    }
}
