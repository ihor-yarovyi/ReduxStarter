//
//  ShapeProvider.swift
//  UICore
//
//  Created by Ihor Yarovyi on 10/30/21.
//

import SwiftUI

public protocol ShapeProvider {
    func translucentView(width: CGFloat, height: CGFloat, fillColor: Color, foregroundColor: Color) -> AnyView
    func outerView(lineWidth: CGFloat, foregroundColor: Color) -> AnyView
    func horizontalOuterPartView(lineWidth: CGFloat, foregroundColor: Color) -> AnyView
    func verticalOuterPartView(lineWidth: CGFloat, foregroundColor: Color) -> AnyView
    func crop(_ image: CGImage,
              imageWidth: CGFloat,
              imageHeight: CGFloat,
              croppingOffset: CGSize,
              magnification: CGFloat,
              completion: @escaping ((UIImage?) -> Void))
}
