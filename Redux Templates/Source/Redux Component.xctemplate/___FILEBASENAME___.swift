//
//  ___FILEHEADER___
//

import Foundation

public <#type#> /*enum or struct*/ ___VARIABLE_productName:identifier___ {
    // Uncomment the grop what you need
    // enum
    /*
    case <#none#>
    case <#inProgress#>
    case <#failed(Error)#>
    case <#success#>
    
    init() {
        self = .none
    }
    */
    // or struct
    /*
    public var <#property#>: <#Type#> = <#Default value#>
    */

    mutating func reduce(_ action: Action) {
        // if you use enum
        /*
        switch action {
        case is Actions.<#ActionGroup#>.<#ActionName#>:
            self = <#.inProgress#>
        case let action as Actions.<#ActionGroup#>.<#ActionName#>:
            self = <#.failed(action.error)#>
        case let action as Actions.<#ActionGroup#>.<#ActionName#>:
            self = <#.failed(action.error)#>
        case let action as Actions.<#ActionGroup#>.<#ActionName#>:
            self = <#.failed(action.error)#>
        case is Actions.<#ActionGroup#>.<#ActionName#>:
            self = <#.success#>
        case is Actions.<#ActionGroup#>.<#ActionName#>:
            self = <#.none#>
        default:
            break
        }
        */
        // if you use struct
        /*
        switch action {
        case let action as Actions.<#ActionGroup#>.<#ActionName#>:
            <#property#> = action.<#property#>
        case is Actions.<#ActionGroup#>.<#ActionName#>:
            self = Self() // example when you need reset a form/go to initial state
        default:
            break
        }
        */
    }
}