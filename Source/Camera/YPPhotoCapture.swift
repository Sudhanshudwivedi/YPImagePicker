//
//  YPPhotoCapture.swift
//  YPImagePicker
//
//  Created by Sacha DSO on 08/03/2018.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

protocol YPPhotoCapture: class {
    
    // Public api
    func setup(with previewView: UIView) // try setup with previewView.
    func tryToStartCamera()
    func stopCamera()
    func focus(on point: CGPoint)
    func tryToggleFlash()
    var hasFlash: Bool { get }
    var currentFlashMode: YPFlashMode { get } // putno flash in falshmode.
    func flipCamera()
    func shoot(completion: @escaping (Data) -> Void)
    var videoLayer: AVCaptureVideoPreviewLayer! { get set }
    
    
    // Used in Default extension
    var previewView: UIView! { get }
    func startCamera()
    var isPreviewSetup: Bool { get set }
    var sessionQueue: DispatchQueue { get }
    var session: AVCaptureSession { get }
    var output: AVCaptureOutput { get }
    var deviceInput: AVCaptureDeviceInput! { get set }
    var device: AVCaptureDevice? { get } // not needed
}

func newPhotoCapture() -> YPPhotoCapture {
    if #available(iOS 10.0, *) {
        return PostiOS10PhotoCapture()
    } else {
        return PreiOS10PhotoCapture()
    }
}

enum YPFlashMode {
    case off
    case on
    case auto
}

extension YPFlashMode {
    func flashImage() -> UIImage {
        switch self {
        case .on: return flashOnImage!
        case .off: return flashOffImage!
        case .auto: return flashAutoImage!
        }
    }
}

