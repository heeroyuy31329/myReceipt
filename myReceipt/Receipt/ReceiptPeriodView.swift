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
            List(viewModel.periodsData, id: \.self) { period in
                ZStack {
                    Color(.white)
                        .onTapGesture {
                            viewModel.selectedPeriod = period
                            viewModel.toListPage = true
                        }
                    
                    HStack {
                        Text("\(period.substring(to: 3)) 年 \(PeriodModel.shared.periodToMonth(period: period.substring(from: 3)))")
                        
                        Spacer()
                    }
                    
                }
            }
            .listStyle(PlainListStyle())
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
                ReceiptListView(viewModel: .init(period: viewModel.selectedPeriod))
            } label: {}
            .isDetailLink(false)
        }
        .onAppear {
            viewModel.getPeriodData()
        }
    }
}

struct ReceiptPeriod_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptPeriodView(viewModel: .init())
    }
}
