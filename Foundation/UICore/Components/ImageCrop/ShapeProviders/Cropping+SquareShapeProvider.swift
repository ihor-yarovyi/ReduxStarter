//
//  Cropping+SquareShapeProvider.swift
//  UICore
//
//  Created by Ihor Yarovyi on 10/30/21.
//

import SwiftUI

public extension Cropping {
    struct SquareShapeProvider: ShapeProvider {
        private let cropper: Cropper
        
        public init(cropper: Cropper = SquareCrop()) {
            self.cropper = cropper
        }
        
        public func translucentView(width: CGFloat, height: CGFloat, fillColor: Color, foregroundColor: Color) -> AnyView {
            Rectangle()
                .foregroundColor(foregroundColor)
                .eraseToAnyView()
        }
        
        public func outerView(lineWidth: CGFloat, foregroundColor: Color) -> AnyView {
            Rectangle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(foregroundColor)
                .eraseToAnyView()
        }
        
        public func horizontalOuterPartView(lineWidth: CGFloat, foregroundColor: Color) -> AnyView {
            Rectangle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(foregroundColor)
                .eraseToAnyView()
        }
        
        public func verticalOuterPartView(lineWidth: CGFloat, foregroundColor: Color) -> AnyView {
            Rectangle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(foregroundColor)
                .eraseToAnyView()
        }
        
        public func crop(_ image: CGImage,
                         imageWidth: CGFloat,
                         imageHeight: CGFloat,
                         croppingOffset: CGSize,
                         magnification: CGFloat,
                         completion: @escaping ((UIImage?) -> Void)) {
            cropper.crop(image,
                         imageWidth: imageWidth,
                         imageHeight: imageHeight,
                         croppingOffset: croppingOffset,
                         magnification: magnification,
                         completion: completion)
        }
    }
}
