//
//  PickerView.swift
//  UICore
//
//  Created by Ihor Yarovyi on 10/18/21.
//

import SwiftUI
import Utils

public struct ImagePicker {
    // MARK: - Private Properties
    @Environment(\.presentationMode)
    private var presentationMode
    private let sourceType: Utils.PhotoGallery.Source
    private var selectedImageData: Binding<UIImage?>
    
    // MARK: - Initializators
    public init(sourceType: Utils.PhotoGallery.Source, selectedImageData: Binding<UIImage?>) {
        self.sourceType = sourceType
        self.selectedImageData = selectedImageData
    }
}

// MARK: - UIViewControllerRepresentable
extension ImagePicker: UIViewControllerRepresentable {
    public func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType == .camera ? .camera : .photoLibrary
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Empty implementation
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - Coordinator
public extension ImagePicker {
    final class Coordinator: NSObject {
        private var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ImagePicker.Coordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                self.parent.selectedImageData.wrappedValue = image
                self.parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
