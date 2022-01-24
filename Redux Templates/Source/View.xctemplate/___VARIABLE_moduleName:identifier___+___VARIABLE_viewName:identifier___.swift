//
//  ___FILEHEADER___
//

import SwiftUI
import Resources
import UICore

public extension ___VARIABLE_moduleName:identifier___ {
    struct ___VARIABLE_viewName:identifier___: View {
        let screenAction: <#Action#>
        let screenProgress: <#Progress#>

        public init(screenAction: <#Action#>, screenProgress: <#Progress#>) {
            self.screenAction = screenAction
            self.screenProgress = screenProgress
        }

        public var body: some View {
            VStack {
                title()
                description()
            }
        }
    }
}

// MARK: - Private Views
private extension ___VARIABLE_moduleName:identifier___.___VARIABLE_viewName:identifier___ {
    func title() -> some View {
        Text("Some title")
            .font(Font.system(size: Defaults.Title.fontSize).bold())
    }

    func description() -> some View {
        Text("Some description")
            .font(Font.system(size: Defaults.Description.fontSize))
    }
}

// MARK: - Handle Actions
private extension ___VARIABLE_moduleName:identifier___.___VARIABLE_viewName:identifier___ {
    <#Handle some actions here#>
}

// MARK: - Defaults
private extension ___VARIABLE_moduleName:identifier___.___VARIABLE_viewName:identifier___ {
    enum Defaults {
        enum Title {
            static let fontSize: CGFloat = 34
        }

        enum Description {
            static let fontSize: CGFloat = 24
        }

        enum Buttons {
            enum SomeAction {
                static let fontSize: CGFloat = 15
            }
        }
    }
}

#if DEBUG
struct ___VARIABLE_moduleName:identifier______VARIABLE_viewName:identifier____Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_moduleName:identifier___.___VARIABLE_viewName:identifier___(
            screenAction: <#Action#>,
            screenProgress: <#Progress#>
        )
    }
}
#endif
