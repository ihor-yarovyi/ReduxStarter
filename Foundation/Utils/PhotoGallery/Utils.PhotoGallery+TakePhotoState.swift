//
//  Utils.PhotoGallery+TakePhotoState.swift
//  Utils
//
//  Created by Ihor Yarovyi on 10/16/21.
//

import UIKit

public extension Utils.PhotoGallery {
    enum TakePhotoState: Equatable {
        case none
        case denied(errorMessage: String)
        case failed(errorMessage: String)
        case take(Source)
        case crop(UIImage)
        case compress(UIImage)
        case done(UIImage)
    }
}
