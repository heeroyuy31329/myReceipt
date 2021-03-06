//
//  Receipt.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/26.
//

import Foundation

enum PriceStatus: Int, Codable {
    case noPrice = 0    // 未中將
    case gotPrice = 1   // 有中獎
    case notOpen = 2    // 未開獎
    
    func discription() -> String {
        switch self {
        case .noPrice:
            return "未中獎"
        case .gotPrice:
            return "有中獎"
        case .notOpen:
            return "未開獎"
        }
    }
}

struct Receipt: Codable {
    let receiptId: String                   // 發票號碼
    let year: String                        // 發票開立時間 - 年
    let month: String                       // 發票開立時間 - 月
    let day: String                         // 發票開立時間 - 日
    let period: String                      // 發票開立年期別
    let money: Int                          // 發票金額
    let sellerCode: String                  // 賣方統編
    var isPrize: PriceStatus = .notOpen     // 是否中獎
    var noPrizeNo:String                    // 未中獎的部分 (顯示上分開儲存)
    var gotPrizeNo: String = ""             // 中獎的部分 (顯示上分開儲存)
    var prizeMoney: Int = 0                 // 中獎金額
    var userId: String = "my"               // 使用者id (這邊先寫死資料)
}
