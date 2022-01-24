//
//  Cropping+CropView.swift
//  UICore
//
//  Created by Ihor Yarovyi on 10/30/21.
//

import SwiftUI

extension Cropping {
    struct CropView: View {
        
        // MARK: - Private Properties
        @Binding
        private var imageWidth: CGFloat
        
        @Binding
        private var imageHeight: CGFloat
        
        /// Serves as the starting point for any calculations for each iteration of `onChanged` in a drag gesture
        @Binding
        private var finalOffset: CGSize
        
        /// Serves as the starting point for any calculations for each iteration of `onChanged` in a drag gesture
        @Binding
        private var finalMagnification: CGFloat
        
        /// The `activeOffset` is used to update the view
        @State
        private var activeOffset: CGSize = .zero
        
        /// The `activeMagnification` is used to update the view
        @State
        private var activeMagnification: CGFloat = 1
        
        private var halfOfImageWidth: CGFloat { imageWidth / 2 }
        private var halfOfImageHeight: CGFloat { imageHeight / 2 }
        private var halfOfDimension: CGFloat { dimension() / 2 }
        private let shapeProvider: ShapeProvider
        
        // MARK: - Initializator
        init(shapeProvider: ShapeProvider,
             imageWidth: Binding<CGFloat>,
             imageHeight: Binding<CGFloat>,
             finalOffset: Binding<CGSize>,
             finalMagnification: Binding<CGFloat>) {
            self.shapeProvider = shapeProvider
            _imageWidth = imageWidth
            _imageHeight = imageHeight
            _finalOffset = finalOffset
            _finalMagnification = finalMagnification
        }
        
        // MARK: - Body
        var body: some View {
            ZStack {
                surroundingAreaView()
                translucentView()
                outerView()
                horizontalOuterPartView()
                verticalOuterPartView()
                cornerIconView()
            }
        }
    }
}

// MARK: - Private Subviews
/// Views for surrounding rectangles
private extension Cropping.CropView {
    func leftSurroundRectangleView() -> some View {
        Rectangle()
            .foregroundColor(Defaults.surroundingColor)
            .frame(
                width: abs((imageWidth - dimension()) / 2 + activeOffset.width + (dimension() * (1 - activeMagnification) / 2)),
                height: imageHeight
            )
            .offset(x: surroundingViewOffsets(horizontal: true, leftOrUp: true), y: .zero)
    }
    
    func rightSurroundRectangleView() -> some View {
        Rectangle()
            .foregroundColor(Defaults.surroundingColor)
            .frame(
                width: abs((imageWidth - dimension()) / 2 - activeOffset.width + (dimension() * (1 - activeMagnification) / 2)),
                height: imageHeight
            )
            .offset(x: surroundingViewOffsets(horizontal: true, leftOrUp: false), y: .zero)
    }
    
    func topSurroundRectangleView() -> some View {
        Rectangle()
            .foregroundColor(Defaults.surroundingColor)
            .frame(
                width: dimension() * activeMagnification,
                height: abs((imageHeight - dimension()) / 2 + activeOffset.height + (dimension() * (1 - activeMagnification) / 2))
            )
            .offset(x: activeOffset.width, y: surroundingViewOffsets(horizontal: false, leftOrUp: true))
    }
    
    func bottomSurroundRectangleView() -> some View {
        Rectangle()
            .foregroundColor(Defaults.surroundingColor)
            .frame(
                width: dimension() * activeMagnification,
                height: abs((imageHeight - dimension()) / 2 - activeOffset.height + (dimension() * (1 - activeMagnification) / 2))
            )
            .offset(x: activeOffset.width, y: surroundingViewOffsets(horizontal: false, leftOrUp: false))
    }
    
    func surroundingAreaView() -> some View {
        Group {
            leftSurroundRectangleView()
            rightSurroundRectangleView()
            topSurroundRectangleView()
            bottomSurroundRectangleView()
        }
    }
}

/// A very translucent view that overlies the picture we'll be uploading
private extension Cropping.CropView {
    func translucentView() -> some View {
        let sideSize = dimension() * activeMagnification
        return shapeProvider.translucentView(width: sideSize,
                                             height: sideSize,
                                             fillColor: Defaults.surroundingColor,
                                             foregroundColor: Defaults.translucentColor)
            .frame(width: sideSize, height: sideSize)
            .offset(x: activeOffset.width, y: activeOffset.height)
            .gesture(translucentShapeDragGesture())
    }
}

/// This view creates the white shape
private extension Cropping.CropView {
    /// This view creates the outer circle
    func outerView() -> some View {
        shapeProvider.outerView(lineWidth: Defaults.gridLineWidth, foregroundColor: .white)
            .frame(width: dimension() * activeMagnification, height: dimension() * activeMagnification)
            .offset(x: activeOffset.width, y: activeOffset.height)
    }
    
    /// This view creates a thin view in the center that is 1/3 the outer's width
    func horizontalOuterPartView() -> some View {
        shapeProvider.horizontalOuterPartView(lineWidth: Defaults.gridLineWidth, foregroundColor: Defaults.outerColor)
            .frame(width: dimension() * activeMagnification, height: dimension() * activeMagnification / 3)
            .offset(x: activeOffset.width, y: activeOffset.height)
    }
    
    /// This view creates a thin rectangle in the center that is 1/3 the outer's height
    func verticalOuterPartView() -> some View {
        shapeProvider.verticalOuterPartView(lineWidth: Defaults.gridLineWidth, foregroundColor: Defaults.outerColor)
            .frame(width: dimension() * activeMagnification / 3, height: dimension() * activeMagnification)
            .offset(x: activeOffset.width, y: activeOffset.height)
    }
}

/// Corner icon view
private extension Cropping.CropView {
    func cornerIconView() -> some View {
        Image(systemName: Defaults.ArrowIcon.name)
            .font(.system(size: Defaults.ArrowIcon.fontSize))
            .background(cornerIconBackgroundView())
            .frame(width: Defaults.ArrowIcon.dotSize, height: Defaults.ArrowIcon.dotSize)
            .foregroundColor(.black)
            .offset(
                x: activeOffset.width - activeMagnification * halfOfDimension,
                y: activeOffset.height - activeMagnification * halfOfDimension
            )
            .padding(Defaults.ArrowIcon.padding)
            .gesture(arrowIconDragGesture())
    }
    
    func cornerIconBackgroundView() -> some View {
        Circle()
            .frame(width: Defaults.ArrowIcon.backgroundWidth, height: Defaults.ArrowIcon.backgroundHeight)
            .foregroundColor(Defaults.dotColor)
    }
}

// MARK: - Private Methods
private extension Cropping.CropView {
    /// Returns the larger of two values, when comparing the height and width of the image
    func dimension() -> CGFloat {
        imageHeight > imageWidth ? imageWidth : imageHeight
    }
    
    /// Returns the offset for the surrounding views that obscure what has not been selected in the crop
    func surroundingViewOffsets(horizontal: Bool, leftOrUp: Bool) -> CGFloat {
        let initialOffset: CGFloat = horizontal ? imageWidth : imageHeight
        let signValue: CGFloat = leftOrUp ? -1 : 1
        let compensator = horizontal ? activeOffset.width : activeOffset.height
        
        return (
            (
                (signValue * initialOffset) - (signValue * (initialOffset - dimension()) / 2)
            ) / 2
        )
        + (compensator / 2)
        + (
            -signValue * (dimension() * (1 - activeMagnification) / 4)
        )
    }
    
    /// Update the `activeOffset.width` based on the `workingOffset.width`
    /// - Parameter width: The `workingOffset.width`
    func updateActiveOffsetWidth(from width: CGFloat) {
        /// Check at first if we are within the right and left bounds when translating in the horizontal dimension
        if width + (finalMagnification * halfOfDimension) <= halfOfImageWidth &&
            width - (finalMagnification * halfOfDimension) >= -halfOfImageWidth {
            /// If we are, the set the `activeOffset.width` equal to the `width`
            activeOffset.width = width
        } else if width + (finalMagnification * halfOfDimension) > halfOfImageWidth {
            /// If we are at the right-most bound then align the right-most edges accordingly
            activeOffset.width = halfOfImageWidth - finalMagnification * halfOfDimension
        } else {
            /// If we are at the left-most bound then align the left-most edges accordingly
            activeOffset.width = -halfOfImageWidth + finalMagnification * halfOfDimension
        }
    }
    
    /// Update the `activeOffset.height` based on the `workingOffset.height`
    /// - Parameter height: The `workingOffset.height`
    func updateActiveOffsetHeight(from height: CGFloat) {
        /// Check if we within the upper and lower bounds when translating in the vertical dimension
        if height + finalMagnification * halfOfDimension <= halfOfImageHeight &&
            height - finalMagnification * halfOfDimension >= -halfOfImageHeight {
            /// If we are then set the `activeOffset.height` equal to the `height`
            activeOffset.height = height
        } else if height + finalMagnification * halfOfDimension > halfOfImageHeight {
            /// If we are at the bottom-most bound then align the bottom-most edges accordingly
            activeOffset.height = halfOfImageHeight - finalMagnification * halfOfDimension
        } else {
            /// If we are at the top-most bound then align the top-most edges accordingly
            activeOffset.height = -(halfOfImageHeight - finalMagnification * halfOfDimension)
        }
    }
    
    /// This function determines the intended magnification you were going for.
    /// It does so by measuring the distance you dragged in both dimensions and comparing it against the longest edge of the image.
    /// The larger ratio is determined to be the magnification that you intended
    /// - Parameter translation: The translation from the drag gesture
    /// - Returns: The new magnification
    func computeMagnification(from translation: CGSize) -> CGFloat {
        let horizontalMagnification = (dimension() - translation.width) / dimension()
        let verticalMagnification = (dimension() - translation.height) / dimension()
        
        return horizontalMagnification < verticalMagnification ? horizontalMagnification : verticalMagnification
    }
    
    /// Calculate the working offset during the dragging
    func calculateWorkingOffset() -> CGSize  {
        /// Check the size of the offsets
        let workingOffsetSize = dimension() * finalMagnification - dimension() * activeMagnification
        
        /// Check the offset of the image barring the current `onChanged` we are currently experiencing
        /// by adding the proposed `workingOffsetSize` to the displayed `finalOffset`
        let workingOffset = CGSize(
            width: finalOffset.width + workingOffsetSize / 2,
            height: finalOffset.height + workingOffsetSize / 2
        )
        return workingOffset
    }
    
    /// Update the active magnification with `workingMagnification`
    /// - Parameter workingMagnification: The magnification that was computed during dragging
    func updateActiveMagnification(with workingMagnification: CGFloat) {
        /// -----------------------------------------------------------------
        /// This set of logic is used for calculations that prevent scaling to cause offset to go outside the actual image
        let workingOffset = calculateWorkingOffset()
        
        /// This variable is equal to half of the view finding square, factoring in the magnification
        let proposedHalfSquareSize = dimension() * activeMagnification / 2
        /// -----------------------------------------------------------------
        
        /// Setting up the upper and lower limits of the magnification
        if workingMagnification <= Defaults.upperMagnification && workingMagnification >= Defaults.lowerMagnification {
            /// If we fall within the scaling limits, then we will check that scaling would not extend the
            /// viewfinder past the bounds of the actual image
            if proposedHalfSquareSize - workingOffset.height > halfOfImageHeight ||
                proposedHalfSquareSize - workingOffset.width > halfOfImageWidth {
                activeMagnification = Defaults.lowerMagnification
            } else {
                activeMagnification = workingMagnification
            }
        } else if workingMagnification > Defaults.upperMagnification {
            activeMagnification = Defaults.upperMagnification
        } else {
            activeMagnification = Defaults.lowerMagnification
        }
    }
}

// MARK: - Drag Gestures
private extension Cropping.CropView {
    func translucentShapeDragGesture() -> some Gesture {
        DragGesture()
            .onChanged { drag in
                /// Create an instance of the `workingOffset` that means `finalOffset` + the change made via dragging
                /// The `workingOffset` will be used only for calculations to determine if our drag should be "finalized"
                let workingOffset = CGSize(
                    width: finalOffset.width + drag.translation.width,
                    height: finalOffset.height + drag.translation.height
                )
                
                updateActiveOffsetWidth(from: workingOffset.width)
                updateActiveOffsetHeight(from: workingOffset.height)
            }
            .onEnded { _ in
                /// Set the `finalOffset` equal to the `activeOffset`
                finalOffset = activeOffset
            }
    }
    
    func arrowIconDragGesture() -> some Gesture {
        DragGesture()
            .onChanged { drag in
                /// Calculate the additional magnification this drag is proposing
                let computedMagnification = computeMagnification(from: drag.translation)
                
                /// Multiply it against the magnification that was already present in your crop
                let workingMagnification = finalMagnification * computedMagnification
                
                updateActiveMagnification(with: workingMagnification)
                
                /// As you magnify, you technically need to modify offset as well, because magnification changes are not symmetric,
                /// meaning that you are modifying the magnification only is shifting the upper and left edges inwards,
                /// thus changing the center of the cropped view, so the offset needs to move accordingly
                let offsetSize = dimension() * finalMagnification - dimension() * activeMagnification
                activeOffset.width = finalOffset.width + offsetSize / 2
                activeOffset.height = finalOffset.height + offsetSize / 2
            }
            .onEnded { _ in
                /// At the end you need to set the "final" variables equal to the "active" variables
                finalMagnification = activeMagnification
                finalOffset = activeOffset
            }
    }
}

// MARK: - Defaults
private extension Cropping.CropView {
    enum Defaults {
        static let dotColor = Color.white.opacity(0.9)
        static let surroundingColor = Color.black.opacity(0.45)
        static let translucentColor = Color.white.opacity(0.05)
        static let outerColor = Color.white.opacity(0.6)
        static let gridLineWidth: CGFloat = 1
        static let upperMagnification: CGFloat = 1
        static let lowerMagnification: CGFloat = 0.4
        
        enum ArrowIcon {
            static let name = "arrow.up.left.and.arrow.down.right"
            static let fontSize: CGFloat = 12
            static let backgroundWidth: CGFloat = 20
            static let backgroundHeight: CGFloat = 20
            static let dotSize: CGFloat = 13
            static let padding: CGFloat = 25
        }
    }
}
