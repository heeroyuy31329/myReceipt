//
//  PrizeModel.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/5/2.
//

import Foundation

class PrizeModel {
    static let shared = PrizeModel()
    
    /// 比對發票號碼 (發票號碼, 中獎號碼)
    func compareReceiptNo(_ receipt: Receipt, _ prizeNo: String) -> Bool {
        if prizeNo.isEmpty {
            // 沒有中獎號碼直接返回
            return false
        }
        //let lenth = prizeNo.count   // 紀錄中獎號碼的長度
        let receiptNo = receipt.receiptId
        
//        print("發票號碼： \(receiptNo.substring(from: receiptNo.count - prizeNo.count)), 開獎號碼： \(prizeNo)")
        // 未中獎的才進行比對
        if receipt.isPrize != .gotPrice,
           // 根據中獎號碼的長度，從發票號碼中取出後面的數字進行比對
            receiptNo.substring(from: receiptNo.count - prizeNo.count) == prizeNo {
            return true
        } else {
            return false
        }
    }
    
    // 函式參數預設為let，加上inout讓參數可在函式內做更改並反映到函式外面，達到call by reference的效果，不過呼叫函式的時候參數要加上 &
    /// 比對是否中獎  (發票資料, 中獎資料)
    func compare(_ receipts: inout [Receipt], _ prize: ReceiptPrize) {
        // 這方法會報錯，因為 for in出來的物件是let，不能作變更，而在比對的參數中使用了inout機制會需要修改資料，因此要用下面那種方式利用index的方式直接取得物件
//            for receipt in receiptList {
//                // 特別獎
//                PrizeModel.shared.compareAll(&receipt, prizeData.superPrizeNo, prizeData.superPrizeAmt)
//            }
        
        for i in receipts.indices {
            // 特別獎 - 1000萬元
            if compareReceiptNo(receipts[i], prize.superPrizeNo) {
                // 變更中將資訊
                receipts[i].isPrize = .gotPrice
                receipts[i].noPrizeNo = ""
                receipts[i].gotPrizeNo = prize.superPrizeNo
                receipts[i].prizeMoney = Int(prize.superPrizeAmt) ?? 0
            }
            // 特獎 - 200萬元
            if compareReceiptNo(receipts[i], prize.spcPrizeNo) {
                // 變更中將資訊
                receipts[i].isPrize = .gotPrice
                receipts[i].noPrizeNo = ""
                receipts[i].gotPrizeNo = prize.spcPrizeNo
                receipts[i].prizeMoney = Int(prize.spcPrizeAmt) ?? 0
            }
            
            // 頭獎部分
            let firstPrizeNos = [prize.firstPrizeNo1, prize.firstPrizeNo2, prize.firstPrizeNo3]
            for firstPrizeNo in firstPrizeNos {
                // 比對中獎號碼，8碼、7碼、6碼...3碼
                for count in 0..<6 {
                    let prizeNo = firstPrizeNo.substring(from: count)
//                    print("特獎比對：\(prizeNo)")
                    if compareReceiptNo(receipts[i], prizeNo) {
                        // 變更中將資訊
                        receipts[i].isPrize = .gotPrice
                        receipts[i].noPrizeNo = receipts[i].receiptId.substring(with: 2..<(receipts[i].receiptId.count - prizeNo.count))
                        receipts[i].gotPrizeNo = prizeNo
                        
                        // 根據中將號碼的數量判斷中獎類型
                        switch prizeNo.count {
                        case 3:
                            receipts[i].prizeMoney = Int(prize.sixthPrizeAmt) ?? 0
                        case 4:
                            receipts[i].prizeMoney = Int(prize.fifthPrizeAmt) ?? 0
                        case 5:
                            receipts[i].prizeMoney = Int(prize.fourthPrizeAmt) ?? 0
                        case 6:
                            receipts[i].prizeMoney = Int(prize.thirdPrizeAmt) ?? 0
                        case 7:
                            receipts[i].prizeMoney = Int(prize.secondPrizeAmt) ?? 0
                        case 8:
                            receipts[i].prizeMoney = Int(prize.firstPrizeAmt) ?? 0
                        default:
                            receipts[i].prizeMoney = 0
                        }
                        
                        // 中獎後直接換下一組號碼
                        break
                    }
                }
            }
            
            // 增開六獎 - 200元
            if compareReceiptNo(receipts[i], prize.sixthPrizeNo1) {
                // 變更中將資訊
                receipts[i].isPrize = .gotPrice
                receipts[i].noPrizeNo = receipts[i].receiptId.substring(with: 2..<7)    // 數字部分前5碼
                receipts[i].gotPrizeNo = prize.sixthPrizeNo1                            // 數字部分後3碼
                receipts[i].prizeMoney = Int(prize.sixthPrizeAmt) ?? 0
            }
        }
    }
}
