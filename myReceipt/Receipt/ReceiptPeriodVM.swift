//
//  ReceiptPeriodVM.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/19.
//

import Foundation

class ReceiptPeriodVM: ObservableObject {
    
    // 頁面控制變數
    @Published var toQRCodePage = false     // 跳至QRCode頁面
    @Published var toListPage = false       // 跳至清單頁面
    
    @Published var periodsData = [String]() // 年期別資料(遞減排序)
    @Published var selectedPeriod = ""      // 選到的年期別
    
    init() {
        print("ReceiptPeriodVM init")
    }
    
    func getPeriodData() {
        ReceiptModel.shared.getReceiptPeriodByUser("my") { result in
            switch result {
            case .success(let periods):
                DispatchQueue.main.sync {
                    self.periodsData = periods
                    self.periodsData.sort(by: >)    // 最新的資料在最前面
//                    print("periodsData : \(self.periodsData)")
                }
            case .failure(let error):
                print("getPeriodData error : \(error)")
            }
        }
    }
}
