//
//  Cropper.swift
//  UICore
//
//  Created by Ihor Yarovyi on 10/30/21.
//

import UIKit

public protocol Cropper {
    func crop(_ image: CGImage,
              imageWidth: CGFloat,
              imageHeight: CGFloat,
              croppingOffset: CGSize,
              magnification: CGFloat,
              completion: @escaping ((UIImage?) -> Void))
}
