//
//  ___FILEHEADER___
//

import Redux
import Models
import Core
<#import NetworkClient#>
<#import DatabaseClient#>
<#import Utils#>

public extension SideEffects {
    struct ___VARIABLE_sideEffectName:identifier___<#: RequestManager#> {
        // MARK: - Public Properties
        <#public let databaseClient: DatabaseClient.Instance#>
        public let store: Store
        public var asObserver: Observer {
            Observer(queue: <#QueueProvider.shared.queue#>) { state in
                observe(state: state)
                return .active
            }
        }

        // MARK: - Lifecycle
        public init(store: Store, <#databaseClient: DatabaseClient.Instance#>) {
            self.store = store
            <#self.databaseClient = databaseClient#>
        }

        public func observe(state: AppState) {
            var requests: [NetworkClient.OperatorRequest] = []

            defer {
                NetworkClient.network.process(requests: requests)
            }

            handleSomeFlow(state: state, requests: &requests)
        }
    }
}

// MARK: - Handle Flows
private extension SideEffects.___VARIABLE_sideEffectName:identifier___ {
    func handleSomeFlow(state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        switch state.<#someFlow#> {
        case <#.none#>:
            break
        case <#.action#>:
            onAction(state: state)
        }
    }
}

// MARK: - Handle Actions
private extension SideEffects.___VARIABLE_sideEffectName:identifier___ {
    func onAction(state: AppState) {
        // Handle the specific state
    }
}