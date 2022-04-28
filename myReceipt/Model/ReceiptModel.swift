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
    
    /// 取得年期別資料
    func getReceiptPeriodByUser(_ userId: String, _ result: @escaping (Result<[String], Error>) -> Void) {
        let queryParams = ["userId": userId]
        
        APIModel.shared.requset(method: .get, url: "/receipt/period", queryParameters: queryParams) { responseResult in
            switch responseResult {
            case .success(let data):
                let periods = try! JSONDecoder().decode([String].self, from: data)
                result(.success(periods))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    /// 取得改期別的發票資料
}
