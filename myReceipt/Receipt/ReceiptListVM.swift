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
            // 這方法會報錯，因為 for in出來的物件是let，不能作變更，而在比對的參數中使用了inout機制會需要修改資料，因此要用下面那種方式利用index的方式直接取得物件
//            for receipt in receiptList {
//                // 特別獎
//                PrizeModel.shared.compareAll(&receipt, prizeData.superPrizeNo, prizeData.superPrizeAmt)
//            }
            
            for i in receiptList.indices {
                // 特別獎 - 1000萬元
                PrizeModel.shared.compareAll(&receiptList[i], prizeData.superPrizeNo, prizeData.superPrizeAmt)
                // 特獎 - 200萬元
                PrizeModel.shared.compareAll(&receiptList[i], prizeData.spcPrizeNo, prizeData.spcPrizeAmt)
                
                // 增開六獎 - 200元
                PrizeModel.shared.compareAll(&receiptList[i], prizeData.sixthPrizeNo1, prizeData.sixthPrizeAmt)
            }

            print("兌獎結果：\(receiptList)")
        }
    }
}
