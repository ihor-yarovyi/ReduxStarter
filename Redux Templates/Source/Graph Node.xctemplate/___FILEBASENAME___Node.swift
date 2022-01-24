//
//  ___FILEHEADER___
//

import Models

public extension Graph {
    var <#nodeName#>: ___VARIABLE_productName:identifier___Node {
        ___VARIABLE_productName:identifier___Node(graph: self)
    }
}

public struct ___VARIABLE_productName:identifier___Node {
    let graph: Graph

    public var <#property#>: <#Type#> {
        get {
            graph.state.<#someForm#>.<#someProperty#>
        }
        nonmutating set {
            graph.dispatch(Actions.<#ActionGroup#>.<#ActionName#>(<#arg:#> newValue))
        }
    }

    public func <#doSomething#>() {
        graph.dispatch(Actions.<#ActionGroup#>.<#ActionName#>())
    }
}