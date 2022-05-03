//
//  ReceiptListVM.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/19.
//

import Foundation

class ReceiptListVM: ObservableObject {
    @Published var period: String!
    
    @Published var receiptList = [Receipt]()
    
    var receiptPrizeData = [String: ReceiptPrize]()
    
    init(period: String?) {
        self.period = period
//        print("ReceiptListVM init : \(self.period)")
    }
    
    func getReceiptList() {
        ReceiptModel.shared.getReceiptListByUser("my", period) { result in
            switch result {
            case .success(let receiptList):
                DispatchQueue.main.async {
                    self.receiptList = receiptList
                    self.receiptList.sort {
                        $0.receiptId < $1.receiptId     // 根據發票號碼排序
                    }
//                    print("receiptList : \(self.receiptList)")
                    
                    if self.receiptPrizeData[self.period] == nil {
                        // 取得當期中將號碼資訊
                        ReceiptPrizeModel.shared.getReceiptPrizeByPeriod(self.period) { result in
                            switch result {
                            case .success(let data):
                                DispatchQueue.main.async {
                                    self.receiptPrizeData[self.period] = data
//                                    print("getReceiptPrizeByPeriod receiptPrizeData : \(self.receiptPrizeData)")
//                                    print("取資料後兌獎")
                                    self.comparePrize()
                                }
                            case .failure(let error):
                                print("getReceiptPrizeByPeriod error : \(error)")
                            }
                        }
                    } else {
                        print("直接兌獎")
                    }
                    
                }
            case .failure(let error):
                print("getPeriodData error : \(error)")
            }
        }
    }
    
    func comparePrize() {
        // 取出當期別的中獎資料
        if let prizeData = receiptPrizeData[period] {
            PrizeModel.shared.compare(&receiptList, prizeData)
//            print("兌獎結果：\(receiptList)")
        }
    }
}
