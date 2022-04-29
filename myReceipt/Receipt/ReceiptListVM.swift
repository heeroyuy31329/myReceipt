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
                }
            case .failure(let error):
                print("getPeriodData error : \(error)")
            }
        }
    }
}
