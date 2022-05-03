//
//  QRCodeScanVM.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/19.
//

import Foundation

class QRCodeScanVM: ObservableObject {
    @Published var isScanEnd = false    // 掃描結束
    
    init() {
//        print("QRCodeScanVM init")
    }
}

extension QRCodeScanVM: QRScannerViewDelegate {
    func qrScanningSucceededWithCode(_ str: [String]?) {
        if let receiptQRCodes = str {
            QRCodeModel.shared.parseQRCode(receiptQRCodes) { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
//                        print("ScanEnd")
                        self.isScanEnd = true
                    }
                case .failure(_):
                    print("QR code 掃描失敗")
                }
                
            }
        }
    }
    
    func qrScanningDidFail() {
//        print("qrScanningDidFail")
    }
    
    func qrScanningDidStop() {
//        print("qrScanningDidStop")
    }
}
