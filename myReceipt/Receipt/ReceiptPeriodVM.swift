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
    
    init() {
        print("ReceiptPeriodVM init")
    }
}
