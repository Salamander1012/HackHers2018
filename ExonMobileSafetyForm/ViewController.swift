//
//  ViewController.swift
//  ExonMobileSafetyForm
//
//  Created by Salman Fakhri on 2/24/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, NavigationProtocol {

    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var photoPreviewLayer: UIView!
    @IBOutlet weak var previewImage: UIImageView!
    
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var retakeButton: UIButton!
    @IBOutlet weak var useImageButton: UIButton!
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var captureDevice: AVCaptureDevice?
    
    var backFacingCamera: AVCaptureDevice?
    var frontFacingCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    
    // double tap to switch from back to front facing camera
    var toggleCameraGestureRecognizer = UITapGestureRecognizer()
    
    var capturePhotoOutput: AVCapturePhotoOutput?
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "View forms", style: .plain, target: self, action: #selector(goToTable))
        navigationItem.rightBarButtonItem?.tintColor = .white
        

        
        photoPreviewLayer.isHidden = true
        
        //capture button style
        captureButton.layer.cornerRadius = 35
        captureButton.layer.borderWidth = 3
        captureButton.layer.borderColor = UIColor.lightGray.cgColor
        
        //retake button style
        retakeButton.backgroundColor = .white
        retakeButton.layer.cornerRadius = 6
        retakeButton.setTitleColor(.black, for: .normal)
        
        //retake button style
        useImageButton.backgroundColor = .white
        useImageButton.layer.cornerRadius = 6
        useImageButton.setTitleColor(.black, for: .normal)
        
        
        
        captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let devices = AVCaptureDevice.devices(for: AVMediaType.video) as! [AVCaptureDevice]
        for device in devices {
            if device.position == .back {
                backFacingCamera = device
            } else if device.position == .front {
                frontFacingCamera = device
            }
        }
        
        // default device
        currentDevice = frontFacingCamera
        
        do {
            let input = try AVCaptureDeviceInput(device: currentDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            // Get an instance of ACCapturePhotoOutput class
            capturePhotoOutput = AVCapturePhotoOutput()
            capturePhotoOutput?.isHighResolutionCaptureEnabled = true
            // Set the output on the capture session
            captureSession?.addOutput(capturePhotoOutput!)
        } catch {
            print(error)
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        cameraView.layer.addSublayer(videoPreviewLayer!)
        
        captureSession?.startRunning()
        
        // toggle the camera
        toggleCameraGestureRecognizer.numberOfTapsRequired = 2
        toggleCameraGestureRecognizer.addTarget(self, action: #selector(toggleCamera))
        view.addGestureRecognizer(toggleCameraGestureRecognizer)
    }
    
    @objc func goToTable() {
        performNavigation(currentView: self, destination: .tableView)
    }
    
    @IBAction func retakePhoto(_ sender: Any) {
        self.photoPreviewLayer.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func useImage(_ sender: Any) {
        performNavigation(currentView: self, destination: .formView)
        self.photoPreviewLayer.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    @objc func toggleCamera() {
        // start the configuration change
        captureSession?.beginConfiguration()
        
        let newDevice = (currentDevice?.position == . back) ? frontFacingCamera : backFacingCamera
        
        for input in (captureSession?.inputs)! {
            captureSession?.removeInput(input as! AVCaptureDeviceInput)
        }
        
        let cameraInput: AVCaptureDeviceInput
        do {
            cameraInput = try AVCaptureDeviceInput(device: newDevice!)
        } catch let error {
            print(error)
            return
        }
        
        if (captureSession?.canAddInput(cameraInput))! {
            captureSession?.addInput(cameraInput)
        }
        
        currentDevice = newDevice
        captureSession?.commitConfiguration()
    }
    
    @IBAction func capturePressed(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = true
        // Make sure capturePhotoOutput is valid
        guard let capturePhotoOutput = self.capturePhotoOutput else { return }
        // Get an instance of AVCapturePhotoSettings class
        let photoSettings = AVCapturePhotoSettings()
        // Set photo settings for our need
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .off
        // Call capturePhoto method by passing our photo settings and a
        // delegate implementing AVCapturePhotoCaptureDelegate
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                     previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                 resolvedSettings: AVCaptureResolvedPhotoSettings,
                 bracketSettings: AVCaptureBracketedStillImageSettings?,
                 error: Error?) {
        guard error == nil,
            let photoSampleBuffer = photoSampleBuffer else {
                print("Error capturing photo: \(String(describing: error))")
                return
        }
        // Convert photo same buffer to a jpeg image data by using // AVCapturePhotoOutput
        guard let imageData =
            AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) else {
                return
        }
        // Initialise a UIImage with our image data
        let capturedImage = UIImage.init(data: imageData , scale: 1.0)
        
        if let image = capturedImage {
            // Save our captured image to photos album
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            
            previewImage.image = image
//            if currentDevice?.position == .front {
//                previewImage.transform = CGAffineTransform(scaleX: -1, y: 1)
//            }
            photoPreviewLayer.isHidden = false
            
        }
    
    }
    
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        prepareForNavigation(currentView: self, destination: .formView, segue: segue, sender: self.previewImage.image)
    }
}
