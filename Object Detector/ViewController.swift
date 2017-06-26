//
//  ViewController.swift
//  Object Detector
//
//  Created by Rob Whitaker on 26/06/2017.
//  Copyright © 2017 RWAPP. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
	
	@IBOutlet private weak var cameraView: UIView?
	@IBOutlet private weak var textLayer: UILabel?
	
	private let visionSequenceHandler = VNSequenceRequestHandler()
	private lazy var cameraLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
	private lazy var captureSession: AVCaptureSession = {
		let session = AVCaptureSession()
		session.sessionPreset = AVCaptureSession.Preset.photo
		guard
			let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
			let input = try? AVCaptureDeviceInput(device: backCamera)
			else {
				print("no camera is available.");
				return session
				
		}
		session.addInput(input)
		return session
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.cameraView?.layer.addSublayer(self.cameraLayer)
		
		let videoOutput = AVCaptureVideoDataOutput()
		
		videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "DispatchQueue"))
		self.captureSession.addOutput(videoOutput)
		cameraLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
		
		// begin the session
		self.captureSession.startRunning()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		// make sure the layer is the correct size
		self.cameraLayer.frame = (self.cameraView?.frame)!
	}


}

