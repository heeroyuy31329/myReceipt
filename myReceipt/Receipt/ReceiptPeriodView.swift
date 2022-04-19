//
//  ReceiptPeriod.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/16.
//

import SwiftUI

struct ReceiptPeriodView: View {
    @StateObject var viewModel: ReceiptPeriodVM
    
    @State var toListPage = false
    
    var body: some View {
        VStack {
            Text("ReceiptPeriod")
            Button ("next") {
                toListPage = true
            }
        }
        .navigationTitle("年期")
        .background {
            // MARK: NavigationLink
            NavigationLink(isActive: $toListPage) {
                ReceiptListView(viewModel: .init())
            } label: {}
            .isDetailLink(false)
        }
    }
}

struct ReceiptPeriod_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptPeriodView(viewModel: .init())
    }
}
