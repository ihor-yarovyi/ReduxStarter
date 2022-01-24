//
//  Data+Downsample.swift
//  Utils
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import UIKit

public extension Data {
    func downsample(to pointSize: CGSize, scale: CGFloat = UIScreen.main.scale) -> Data? {
        guard let imageSource = CGImageSourceCreateWithData(self as CFData, [kCGImageSourceShouldCache: false] as CFDictionary) else {
            return nil
        }
        let maxDimensionInPixels = Swift.max(pointSize.width, pointSize.height) * scale
        let sampleOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                             kCGImageSourceShouldCacheImmediately: true,
                             kCGImageSourceCreateThumbnailWithTransform: true,
                             kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
        if let sampleImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, sampleOptions) {
            return UIImage(cgImage: sampleImage).jpegData(compressionQuality: 0.9)
        }
        return nil
    }
}
