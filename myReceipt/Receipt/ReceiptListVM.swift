//
//  ReceiptListVM.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/19.
//

import Foundation

class ReceiptListVM: ObservableObject {
    @Published var period: String!
    
    init(period: String?) {
        self.period = period
//        print("ReceiptListVM init : \(self.period)")
    }
}
