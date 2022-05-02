//
//  ReceiptPrizeModel.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/5/1.
//

import Foundation

class ReceiptPrizeModel {
    static let shared = ReceiptPrizeModel()
    
    func getReceiptPrizeByPeriod(_ peroid: String, _ result: @escaping (Result<ReceiptPrize, Error>) -> Void) {
        // 透過API取得當期中將號碼資訊 (先寫死固定資料)
        let receiptPrize = ReceiptPrize(v: "0.1",
                                        code: "200",
                                        msg: "查詢成功",
                                        invoYm: peroid,
                                        superPrizeNo: "18927486",// 18927486
                                        spcPrizeNo: "82050976",// 82050976
                                        spcPrizeNo2: "",
                                        spcPrizeNo3: "",
                                        firstPrizeNo1: "46596321",
                                        firstPrizeNo2: "75704516",
                                        firstPrizeNo3: "48632657",
                                        firstPrizeNo4: "",
                                        firstPrizeNo5: "",
                                        firstPrizeNo6: "",
                                        firstPrizeNo7: "",
                                        firstPrizeNo8: "",
                                        firstPrizeNo9: "",
                                        firstPrizeNo10: "",
                                        sixthPrizeNo1: "",  // 之後要新增來測試
                                        sixthPrizeNo2: "",
                                        sixthPrizeNo3: "",
                                        superPrizeAmt: "10000000",
                                        spcPrizeAmt: "02000000",
                                        firstPrizeAmt: "00200000",
                                        secondPrizeAmt: "00040000",
                                        thirdPrizeAmt: "00010000",
                                        fourthPrizeAmt: "00004000",
                                        fifthPrizeAmt: "00001000",
                                        sixthPrizeAmt: "00000200",
                                        sixthPrizeNo4: "",
                                        sixthPrizeNo5: "",
                                        sixthPrizeNo6: "")
        
        result(.success(receiptPrize))
    }
}
