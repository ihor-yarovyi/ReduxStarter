//
//  Utils.DeepLink+Handler.swift
//  Utils
//
//  Created by Ihor Yarovyi on 9/30/21.
//

import Foundation

public extension Utils.DeepLink {
    struct Handler {
        public static func handleUserActivity(with url: URL) -> Utils.DeepLink.Kind? {
            if let kind = handleDeepLink(url: url) {
                return kind
            } else if let kind = handleUniversalLink(url: url) {
                return kind
            }
            
            return nil
        }
    }
}

// MARK: - Private Methods
private extension Utils.DeepLink.Handler {
    static func handleUniversalLink(url: URL) -> Utils.DeepLink.Kind? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        
        switch url.host {
        case Defaults.passwordVerification.rawValue:
            guard let token = components.queryItems?.first(where: { $0.name == Defaults.token.rawValue })?.value else { return nil }
            return .restorePassword(token: token)
        default:
            return nil
        }
    }
    
    static func handleDeepLink(url: URL) -> Utils.DeepLink.Kind? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let urlString = components.queryItems?.first(where: { $0.name == Defaults.link.rawValue })?.value,
              let url = URL(string: urlString),
              let pathComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        
        if url.path.lowercased().contains(Defaults.verification.rawValue) {
            guard let token = pathComponents.queryItems?.first(where: { $0.name == Defaults.token.rawValue })?.value else { return nil }
            return .verifiedEmail(token: token)
        } else {
            return nil
        }
    }
}

// MARK: - Defaults
private extension Utils.DeepLink.Handler {
    enum Defaults: String {
        case passwordVerification = "restore-password"
        case verification
        case token
        case link
    }
}
