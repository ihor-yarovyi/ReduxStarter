//
//  Permission+Camera.swift
//  Utils
//
//  Created by Ihor Yarovyi on 10/10/21.
//

import AVFoundation

public extension Utils.Permission where Kind == Utils.PermissionTypes.Camera {
    static func check(completion: @escaping (Utils.PermissionStatus) -> Void) {
        completion(status())
    }
    
    static func request(completion: @escaping (Utils.PermissionStatus) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { _ in
            completion(status())
        }
    }
    
    static func requestIfNotDenied(completion: @escaping (Utils.PermissionStatus) -> Void) {
        let permissionStatus = status()
        switch permissionStatus {
        case .authorized, .denied:
            completion(permissionStatus)
        case .notDetermined:
            request(completion: completion)
        }
    }
    
    private static func status() -> Utils.PermissionStatus {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        case .denied, .restricted:
            return .denied
        @unknown default:
            return .denied
        }
    }
}
