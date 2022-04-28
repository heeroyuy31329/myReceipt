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
        Text("ReceiptList")
            .navigationTitle("細節")
    }
}

struct ReceiptList_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptListView(viewModel: .init(period: nil))
    }
}
