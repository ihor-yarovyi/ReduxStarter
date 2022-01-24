//
//  Cropping+SquareCrop.swift
//  UICore
//
//  Created by Ihor Yarovyi on 10/30/21.
//

import UIKit

public extension Cropping {
    class SquareCrop: Cropper {
        public init() {}
        
        public func crop(_ image: CGImage,
                         imageWidth: CGFloat,
                         imageHeight: CGFloat,
                         croppingOffset: CGSize,
                         magnification: CGFloat,
                         completion: @escaping ((UIImage?) -> Void)) {
            DispatchQueue.global().async {
                let scaler = CGFloat(image.width) / imageWidth
                let dimensionValue = self.dimension(width: CGFloat(image.width), height: CGFloat(image.height))
                let offsetPart = self.dimension(width: imageWidth, height: imageHeight) * magnification / 2
                let xOffset = ((imageWidth / 2) - offsetPart + croppingOffset.width) * scaler
                let yOffset = ((imageHeight / 2) - offsetPart + croppingOffset.height) * scaler
                let scaledDimension = dimensionValue * magnification
                let rect = CGRect(x: xOffset, y: yOffset, width: scaledDimension, height: scaledDimension)
                
                if let cgImage = image.cropping(to: rect) {
                    completion(UIImage(cgImage: cgImage))
                }
            }
        }
        
        /// Returns the larger of two values, when comparing the height and width of the image
        private func dimension(width: CGFloat, height: CGFloat) -> CGFloat {
            height > width ? width : height
        }
    }
}
