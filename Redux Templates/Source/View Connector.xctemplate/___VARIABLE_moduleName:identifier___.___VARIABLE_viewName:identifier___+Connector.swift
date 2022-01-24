//
//  ___FILEHEADER___
//

import SwiftUI
import Redux
import Core

public extension ___VARIABLE_moduleName:identifier___.___VARIABLE_viewName:identifier___ {
    struct Connector: Redux.Connector {
        public init() {}

        public func map(graph: Graph) -> some View {
            ___VARIABLE_moduleName:identifier___.___VARIABLE_viewName:identifier___(
                value: /*Binding(get: {
                    graph.someForm.value
                }, set: {
                    graph.someForm.value = $0
                })*/ <#.empty#>,
                screenAction: /*.available(graph.someForm.action)*/ <#.unavailable#>,
                screenProgress: /*graph.someForm.screenProgress*/ <#.none#>
            )
        }
    }
}

/*
extension SomeNode {
    var screenProgress: ___VARIABLE_moduleName:identifier___.___VARIABLE_viewName:identifier___.Progress {
        switch progress {
        case .none:
            return .none
        case .inProgress:
            return .active
        case .success:
            return .none
        case let .failed(error):
            return .failed(error)
        }
    }
}
*/
