//
//  SideEffect+QueueProvider.swift
//  SideEffects
//
//  Created by Ihor Yarovyi on 01.01.2022.
//

import Foundation

extension SideEffects {
    final class QueueProvider {
        static let shared = QueueProvider()
        let queue = DispatchQueue(label: "side.effect.queue", qos: .utility)
        
        private init() {}
    }
}
