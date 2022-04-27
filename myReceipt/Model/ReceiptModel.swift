//
//  ReceiptModel.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/26.
//

import Foundation

class ReceiptModel {
    static let shared = ReceiptModel()
    
    ///  傳送資料到server
    func putReceiptToServer(_ receipt: Receipt, _ result: @escaping (Result<NSNull, Error>) -> Void) {
        let jsonData = try! JSONEncoder().encode(receipt)
        
        APIModel.shared.requset(method: .put, url: "/receipt", body: jsonData) { responseResult in
            switch responseResult {
            case .success(_):
                result(.success(NSNull()))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
