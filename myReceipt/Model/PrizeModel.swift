//
//  PrizeModel.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/5/2.
//

import Foundation

class PrizeModel {
    static let shared = PrizeModel()
    
    // 函式參數預設為let，加上inout讓參數可在函式內做更改並反映到函式外面，達到call by reference的效果，不過呼叫函式的時候參數要加上 &
    /// 全部比對 (發票資料, 中獎號碼, 獎項金額)
    func compareAll(_ receipt: inout Receipt, _ prizeNo: String, _ prizeMoney: String) {
        
        if prizeNo.isEmpty {
            // 沒有中獎號碼直接返回
            return
        }
        //let lenth = prizeNo.count   // 紀錄中獎號碼的長度
        let receiptNo = receipt.receiptId
        
        print("發票號碼： \(receiptNo.substring(from: receiptNo.count - prizeNo.count)), 開獎號碼： \(prizeNo)")
        // 未中獎的才進行比對
        if receipt.isPrize != .gotPrice,
           // 根據中獎號碼的長度，從發票號碼中取出後面的數字進行比對
            receiptNo.substring(from: receiptNo.count - prizeNo.count) == prizeNo {
            print("有中獎")
            receipt.isPrize = .gotPrice
            receipt.prizeMoney = Int(prizeMoney) ?? 0
        } else {
            print("沒中獎")
        }
    }
    
    /// 部分比對
    func comparePartial() {
        
    }
}
