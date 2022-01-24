//
//  UIImage+Compress.swift
//  Utils
//
//  Created by Ihor Yarovyi on 11/3/21.
//

import UIKit

public extension UIImage {
    func compress(toMB size: Double = 3, deltaStep: CGFloat = 0.1, completion: @escaping (UIImage?) -> Void) {
        var needCompression = true
        var compressionDelta: CGFloat = 1.0
        let maxSize: Int = Int(size * 1024 * 1024)

        DispatchQueue.global().async {
            while needCompression {
                guard let data = self.jpegData(compressionQuality: compressionDelta) else {
                    needCompression = false
                    completion(nil)
                    return
                }
                if data.count < maxSize {
                    needCompression = false
                    completion(UIImage(data: data))
                } else {
                    compressionDelta -= deltaStep
                }
            }
        }
    }
}
