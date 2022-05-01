//
//  ReceiptList.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/16.
//

import SwiftUI

struct ReceiptListView: View {
    @StateObject var viewModel: ReceiptListVM
    
    var body: some View {
        VStack {
            List(viewModel.receiptList, id: \.receiptId) { receipt in
                
                HStack {
                    VStack(alignment: .leading, spacing: 5.0) {
                        Text("發票號碼：\(receipt.receiptId.substring(to: 2))-\(receipt.receiptId.substring(from: 2))")
                        
                        Text("消費日期：\(receipt.year) 年 \(receipt.month) 月 \(receipt.day) 日")
                        
                        Text("消費金額：\(receipt.money) 元")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 5.0) {
                        Text(receipt.isPrize.discription())
                        Text("\(receipt.prizeMoney) 元")
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("\(viewModel.period.substring(to: 3)) 年 \(PeriodModel.shared.periodToMonth(period: viewModel.period.substring(from: 3)))")
        .onAppear {
            viewModel.getReceiptList()
        }
    }
}

struct ReceiptList_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptListView(viewModel: .init(period: nil))
    }
}
