//
//  ___FILEHEADER___
//

import SwiftUI
import Resources
import UICore

public extension ___VARIABLE_productName:identifier___ {
    struct MainView: View {
        var value: Binding<String>
        let screenAction: Action
        let screenProgress: Progress

        public init(value: Binding<String>,
                    screenAction: Action,
                    screenProgress: Progress) {
            self.value = value
            self.screenAction = screenAction
            self.screenProgress = screenProgress
        }

        public var body: some View {
            VStack {
                title()
                description()
                someActionButton()
            }
            .isLoading(screenProgress == .active)
            .errorAlert(isPresented: .constant(screenProgress.isPresented), with: screenProgress.message)
        }
    }
}

// MARK: - Private Views
private extension ___VARIABLE_productName:identifier___.MainView {
    func title() -> some View {
        Text("Some title")
            .font(Font.system(size: Defaults.Title.fontSize).bold())
    }

    func description() -> some View {
        Text("Some description")
            .font(Font.system(size: Defaults.Description.fontSize))
    }

    func someActionButton() -> some View {
        Button(action: {
            onAction()
        }, label: {
            Spacer()
            Text("Tap me!")
                .font(Font.system(size: Defaults.Buttons.SomeAction.fontSize))
            Spacer()
        })
    }
}

// MARK: - Handle Actions
private extension ___VARIABLE_productName:identifier___.MainView {
    func onAction() {
        guard case let .available(action) = screenAction else { return }
        action()
    }
}

// MARK: - Defaults
private extension ___VARIABLE_productName:identifier___.MainView {
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
struct ___VARIABLE_productName:identifier___View_Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName:identifier___.MainView(
            value: .empty,
            screenAction: .unavailable,
            screenProgress: .none
        )
    }
}
#endif
