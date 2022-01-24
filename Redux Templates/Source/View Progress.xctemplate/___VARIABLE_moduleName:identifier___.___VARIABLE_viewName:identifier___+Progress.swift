//
//  ___FILEHEADER___
//

import SwiftUI

public extension ___VARIABLE_moduleName:identifier___.___VARIABLE_viewName:identifier___ {
    enum Progress {
        case none
        case active
        case failed(Error)
    }
}

// MARK: - Equatable
extension ___VARIABLE_moduleName:identifier___.___VARIABLE_viewName:identifier___.Progress: Equatable {
    public static func == (lhs: ___VARIABLE_moduleName:identifier___.___VARIABLE_viewName:identifier___.Progress, rhs: ___VARIABLE_moduleName:identifier___.___VARIABLE_viewName:identifier___.Progress) -> Bool {
        if case .none = lhs, case .none = rhs {
            return true
        } else if case .active = lhs, case .active = rhs {
            return true
        } else if case let .failed(lError) = lhs, case let .failed(rError) = rhs {
            return lError.localizedDescription == rError.localizedDescription
        }
        return false
    }
}

// MARK: - Internal Properties
extension ___VARIABLE_moduleName:identifier___.___VARIABLE_viewName:identifier___.Progress {
    var isPresented: Bool {
        guard case .failed = self else { return false }
        return true
    }
    
    var message: Text? {
        guard case let .failed(error) = self else { return nil }
        return Text(error.localizedDescription)
    }
}
