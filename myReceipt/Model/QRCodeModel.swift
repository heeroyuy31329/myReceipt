//
//  QRCodeModel.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/26.
//

import Foundation

class QRCodeModel {
    static let shared = QRCodeModel()
    
    func parseQRCode(_ qrCodeStrings: [String], _ result: @escaping (Result<NSNull, Error>) -> Void) {
        let qrCodeString = qrCodeStrings[0] // 第一筆資料為發票基本資料
        
        // 計算年期別
        let year = qrCodeString.substring(with: 10..<13)
        let month = qrCodeString.substring(with: 13..<15)
        let period = year + PeriodModel.shared.monthToPeriod(month: month)
        
        // 消費金額轉換，16進制 -> 10進制
        let money = Int(qrCodeString.substring(with: 29..<37), radix: 16) ?? 0
        
        // 建立物件
        let receipt = Receipt(receiptId: qrCodeString.substring(with: 0..<10),
                              year: year,
                              month: month,
                              day: qrCodeString.substring(with: 15..<17),
                              period: period,
                              money: money,
                              sellerCode: qrCodeString.substring(with: 45..<53),
                              noPrizeNo: qrCodeString.substring(with: 2..<10))
        
        ReceiptModel.shared.putReceiptToServer(receipt) { _ in
            result(.success(NSNull()))
        }
//        print("receipt : \(receipt)")
    }
}
