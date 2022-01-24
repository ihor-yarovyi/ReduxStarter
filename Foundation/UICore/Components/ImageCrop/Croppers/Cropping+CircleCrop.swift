//
//  Cropping+CircleCrop.swift
//  UICore
//
//  Created by Ihor Yarovyi on 10/30/21.
//

import UIKit

public extension Cropping {
    final class CircleCrop: SquareCrop {
        public override init() {
            super.init()
        }
        
        public override func crop(_ image: CGImage,
                                  imageWidth: CGFloat,
                                  imageHeight: CGFloat,
                                  croppingOffset: CGSize,
                                  magnification: CGFloat,
                                  completion: @escaping ((UIImage?) -> Void)) {
            super.crop(image,
                       imageWidth: imageWidth,
                       imageHeight: imageHeight,
                       croppingOffset: croppingOffset,
                       magnification: magnification) { image in
                completion(image?.cropToCircle())
            }
        }
    }
}
