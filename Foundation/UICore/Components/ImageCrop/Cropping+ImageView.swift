//
//  Cropping+ImageView.swift
//  UICore
//
//  Created by Ihor Yarovyi on 10/30/21.
//

import SwiftUI
import Resources

public extension Cropping {
    struct ImageView: View {
        // MARK: - Private Properties
        @State
        private var imageWidth: CGFloat = .zero
        
        @State
        private var imageHeight: CGFloat = .zero
        
        @State
        private var croppingOffset: CGSize = .zero
        
        @State
        private var croppingMagnification: CGFloat = 1
        
        @Environment(\.presentationMode)
        private var presentationMode
        
        private let image: UIImage
        private let shapeProvider: ShapeProvider
        private let onCancel: () -> Void
        private let onCrop: (UIImage?) -> Void
        
        // MARK: - Initializators
        public init(_ image: UIImage,
                    shape: ShapeProvider,
                    onCancel: @escaping () -> Void,
                    onCrop: @escaping (UIImage?) -> Void) {
            self.image = image
            self.shapeProvider = shape
            self.onCancel = onCancel
            self.onCrop = onCrop
        }
        
        // MARK: - Body
        public var body: some View {
            VStack {
                headerView()
                Spacer()
                imageContainerView()
                Spacer()
            }
        }
    }
}

// MARK: - Private Subviews
private extension Cropping.ImageView {
    func cancelButton() -> some View {
        Button(Strings.ImageCroppingView.Actions.cancel, action: onCancelHalper).padding()
    }
    
    func cropButton() -> some View {
        Button(Strings.ImageCroppingView.Actions.crop, action: onCropHalper).padding()
    }
    
    func headerView() -> some View {
        HStack {
            cancelButton()
            Spacer()
            cropButton()
        }
    }
    
    func imageView() -> some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            // This overlay is necessary just for setting the image sizes
            .overlay(GeometryReader { geometry -> AnyView in
                DispatchQueue.main.async {
                    self.imageWidth = geometry.size.width
                    self.imageHeight = geometry.size.height
                }
                return EmptyView().eraseToAnyView()
            })
    }
    
    func imageContainerView() -> some View {
        ZStack {
            imageView()
            Cropping.CropView(
                shapeProvider: shapeProvider,
                imageWidth: $imageWidth,
                imageHeight: $imageHeight,
                finalOffset: $croppingOffset,
                finalMagnification: $croppingMagnification
            )
        }
    }
}

// MARK: - Handle Actions
private extension Cropping.ImageView {
    func onCancelHalper() {
        presentationMode.wrappedValue.dismiss()
        onCancel()
    }
    
    func onCropHalper() {
        guard let cgImage = image.cgImage else { return }
        
        shapeProvider.crop(cgImage,
                           imageWidth: imageWidth,
                           imageHeight: imageHeight,
                           croppingOffset: croppingOffset,
                           magnification: croppingMagnification) { image in
            DispatchQueue.main.async {
                presentationMode.wrappedValue.dismiss()
                onCrop(image)
            }
        }
    }
}
