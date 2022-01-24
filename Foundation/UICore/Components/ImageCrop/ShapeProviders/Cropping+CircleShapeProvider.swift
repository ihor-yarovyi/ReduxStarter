//
//  Cropping+CircleShapeProvider.swift
//  UICore
//
//  Created by Ihor Yarovyi on 10/30/21.
//

import SwiftUI

public extension Cropping {
    struct CircleShapeProvider: ShapeProvider {
        private let cropper: Cropper
        
        public init(cropper: Cropper = CircleCrop()) {
            self.cropper = cropper
        }
        
        public func translucentView(width: CGFloat, height: CGFloat, fillColor: Color, foregroundColor: Color) -> AnyView {
            Rectangle()
                .fill(fillColor)
                .mask(holeShapeMask(height: height, width: width).fill(style: FillStyle(eoFill: true)))
                .eraseToAnyView()
        }
        
        public func outerView(lineWidth: CGFloat, foregroundColor: Color) -> AnyView {
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(foregroundColor)
                .eraseToAnyView()
        }
        
        public func horizontalOuterPartView(lineWidth: CGFloat, foregroundColor: Color) -> AnyView {
            Group {}.eraseToAnyView()
        }
        
        public func verticalOuterPartView(lineWidth: CGFloat, foregroundColor: Color) -> AnyView {
            Group {}.eraseToAnyView()
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
        
        private func holeShapeMask(inset: CGFloat = .zero, height: CGFloat, width: CGFloat) -> Path {
            let rect = CGRect(x: .zero, y: .zero, width: width, height: height)
            let insetRect = CGRect(x: inset, y: inset, width: width - (inset * 2), height: height - (inset * 2))
            var shape = Rectangle().path(in: rect)
            shape.addPath(Circle().path(in: insetRect))
            return shape
        }
    }
}
