//
//  QRScannerUIView.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/20.
//
//                                                              -> AVCaptureVideoPreviewLayer
//                                                              |
// AVCaptureDevice -> AVCaptureDeviceInput -> AVCaptureSession -
//                                                              |
//                                                              -> AVCaptureMetadataOutput -> AVCaptureMetadataOutputObjectsDelegate.metadataOutput() -> QR Code

import Foundation
import UIKit
import AVFoundation
import SwiftUI

// MARK: Delegate
protocol QRScannerViewDelegate: AnyObject {
    func qrScanningSucceededWithCode(_ str: String?)
    func qrScanningDidFail()
    func qrScanningDidStop()
}

class QRScannerUIView: UIView {
    var delegate: QRScannerViewDelegate?
    
    // QR Code掃描的控制物件
    var captureSession: AVCaptureSession?
    
    // 複寫父類別的建構式
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // 因為有自己的建構式，就必須要這個建構式，防止父類別的建構式失傳
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.connection?.videoOrientation = .landscapeLeft
    }
    
    // MARK: 指定layerClass為AVCaptureVideoPreviewLayer
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    override var layer: AVCaptureVideoPreviewLayer {
        return super.layer as! AVCaptureVideoPreviewLayer
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        doSetup()
    }
}

extension QRScannerUIView {
    /// 掃描中？
    var isRunning: Bool {
        return captureSession?.isRunning ?? false
    }
    
    /// 開始掃描
    func startScanning() {
        captureSession?.startRunning()
    }
    
    /// 停止掃描
    func stopScanning() {
        captureSession?.stopRunning()
        captureSession = nil
        delegate?.qrScanningDidStop()
    }
    
    // 建立掃瞄物件
    private func doSetup() {
        //若子示圖超過父示圖的邊界是否做裁減
        clipsToBounds = true
        
        captureSession = AVCaptureSession()
        
        // 使用相機裝置
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        // 輸入資料
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch let error {
            print(error)
            return
        }
        
        // 輸入的資料設定到session中
        if captureSession?.canAddInput(videoInput) ?? false {
            captureSession?.addInput(videoInput)
        } else {
            scanningFail()
            return
        }
        
        // 輸出資料
        // 1. 輸出到畫面
        self.layer.videoGravity = .resizeAspectFill
        self.layer.session = self.captureSession
        
        // 2. 輸出到AVCaptureMetaDataOutput
        let metadataOutput = AVCaptureMetadataOutput()
        DispatchQueue.global().async {
            // 輸出的資料設定到session中
            if self.captureSession?.canAddOutput(metadataOutput) ?? false {
                self.captureSession?.addOutput(metadataOutput)
                
                // 設定輸出要處理的Delegate
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                
                // 設定要處理的資料類型[條碼類型]
                metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417]
                
                // 開始影像擷取
                self.startScanning()
            } else {
                self.scanningFail()
                return
            }
        }
    }
    
    /// 掃描成功
    func scanningSuccess(code: String) {
        delegate?.qrScanningSucceededWithCode(code)
    }
    
    /// 掃描失敗
    func scanningFail() {
        captureSession = nil
        delegate?.qrScanningDidFail()
    }
}

extension QRScannerUIView: AVCaptureMetadataOutputObjectsDelegate {
    // MARK: 掃出來的結果(掃一次進來有可能多個)
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            guard let stringValue = metadataObject.stringValue else { return }
            
            print("QR Code value : \(stringValue)")
            
            scanningSuccess(code: stringValue)
        }
    }
}

// 將UIView轉換成View
struct QrCodeScannerView: UIViewRepresentable {
    typealias UIViewType = QRScannerUIView
    
    let delegate: QRScannerViewDelegate
    
    func makeUIView(context: Context) -> QRScannerUIView {
        let qrScaanerView = QRScannerUIView()
        qrScaanerView.delegate = delegate
        
        return qrScaanerView
    }
    
    func updateUIView(_ uiView: QRScannerUIView, context: Context) {}
}
