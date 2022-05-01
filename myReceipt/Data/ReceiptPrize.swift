//
//  ReceiptPrize.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/5/1.
//

import Foundation

// API 回傳的資料結構
struct ReceiptPrize {
    let v: String // 版本號碼
    let code: String // 訊息回應碼
    let msg: String // 系統回應訊息
    let invoYm: String // 查詢開獎期別
    let superPrizeNo: String // 千萬特獎號碼
    let spcPrizeNo: String // 特獎號碼
    let spcPrizeNo2: String // 特獎號碼 2
    let spcPrizeNo3: String // 特獎號碼3
    let firstPrizeNo1: String // 頭獎號碼 1
    let firstPrizeNo2: String // 頭獎號碼2
    let firstPrizeNo3: String // 頭獎號碼3
    let firstPrizeNo4: String // 頭獎號碼4
    let firstPrizeNo5: String // 頭獎號碼5
    let firstPrizeNo6: String // 頭獎號碼6
    let firstPrizeNo7: String // 頭獎號碼7
    let firstPrizeNo8: String // 頭獎號碼8
    let firstPrizeNo9: String // 頭獎號碼9
    let firstPrizeNo10: String // 頭獎號碼10
    let sixthPrizeNo1: String // 六獎號碼 1
    let sixthPrizeNo2: String // 六獎號碼2
    let sixthPrizeNo3: String // 六獎號碼3
    let superPrizeAmt: String // 千萬特獎金額
    let spcPrizeAmt: String // 特獎金額
    let firstPrizeAmt: String // 頭獎金額
    let secondPrizeAmt: String // 二獎金額
    let thirdPrizeAmt: String // 三獎金額
    let fourthPrizeAmt: String // 四獎金額
    let fifthPrizeAmt: String // 五獎金額
    let sixthPrizeAmt: String // 六獎金額
    let sixthPrizeNo4: String // 六獎號碼 4
    let sixthPrizeNo5: String // 六獎號碼5
    let sixthPrizeNo6: String // 六獎號碼6
}
