//
//  ReceiptPeriod.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/16.
//

import SwiftUI

struct ReceiptPeriodView: View {
    @StateObject var viewModel: ReceiptPeriodVM
    
    var body: some View {
        VStack {
            Text("ReceiptPeriod")
            Button ("next") {
                viewModel.toListPage = true
            }
        }
        .navigationTitle("年期")
        .toolbar {
            Button {
                viewModel.toQRCodePage = true
            } label: {
                Image("icon_add")
            }
            .sheet(isPresented: $viewModel.toQRCodePage) {
                print("dismiss")
            } content: {
                QRCodeScanView(viewModel: .init())
            }
        }
        .background {
            // MARK: NavigationLink
            NavigationLink(isActive: $viewModel.toListPage) {
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
