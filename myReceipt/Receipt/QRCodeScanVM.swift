//
//  QRCodeScanVM.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/19.
//

import Foundation

class QRCodeScanVM: ObservableObject {
    init() {
        print("QRCodeScanVM init")
    }
}

extension QRCodeScanVM: QRScannerViewDelegate {
    func qrScanningSucceededWithCode(_ str: [String]?) {
        if let str = str {
            for receiptQRCode in str {
                print("qrScanningSucceededWithCode : \(receiptQRCode)")
            }
        }
    }
    
    func qrScanningDidFail() {
        print("qrScanningDidFail")
    }
    
    func qrScanningDidStop() {
        print("qrScanningDidStop")
    }
}
