//
//  CameraService.swift
//
//
//  Created by Gabriel Caldeira on 02/12/22.
//  Copyright © 2022 Combate à Fraude. All rights reserved.
//

import Foundation
import AVFoundation

class CameraService {
    
    let math = Math()
    
    private func mathUsege() {
        print("Add: ", math.add(numb1: 2, numb2: 5) )
        print("Sub: ", math.sub(numb1: 2, numb2: 5) )
        print("Mut: ", math.mul(numb1: 2, numb2: 5) )
        print("Div: ", math.div(numb1: 2, numb2: 5) )
    }
    
    var captureSession: AVCaptureSession?
    var delegate: AVCapturePhotoCaptureDelegate?
    
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    
    func start(delegate: AVCapturePhotoCaptureDelegate, completion: @escaping (Error?) -> ()){
        self.delegate = delegate
        mathUsege()
        checkPermissions(completion: completion)
    }
    
    private func checkPermissions(completion: @escaping (Error?) -> ()) {
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                guard granted else { return }
                DispatchQueue.main.async {
                    self.setupCamera(completion: completion)
                }
            }
        case .restricted, .denied:
            break
        case .authorized:
            self.setupCamera(completion: completion)
        @unknown default:
            break
        }
    }
    
    private func setupCamera(completion: @escaping (Error?) -> ()) {
        let session = AVCaptureSession()
        
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input){
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer.session = session
                session.startRunning()
                self.captureSession = session
                
            } catch {
                completion(error)
            }
        }
    }
    
    func caputurePhot(with settings: AVCapturePhotoSettings = AVCapturePhotoSettings()) {
        output.capturePhoto(with: settings, delegate: delegate!)
    }
}
