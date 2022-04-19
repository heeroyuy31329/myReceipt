//
//  MainView.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/16.
//

import SwiftUI

struct MainView: View {
    @State var toQRCodePage = false
    
    var body: some View {
        NavigationView {
            ReceiptPeriodView(viewModel: .init())
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        print("++++")
                        toQRCodePage = true
                    } label: {
                        Image("icon_add")
                    }
                    .sheet(isPresented: $toQRCodePage) {
                        print("dissmis")
                    } content: {
                        QRCodeScanView(viewModel: .init())
                    }

                }
        }
        .navigationViewStyle(.stack)
        //!!!重要!!!不加有可能導致頁面生命週期異常https://stackoverflow.com/questions/63080830/swifui-onappear-gets-called-twice
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
