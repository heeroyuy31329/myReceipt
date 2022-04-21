//
//  QRCodeScanView.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/18.
//

import SwiftUI

struct QRCodeScanView: View {
    // 可用來關閉自己頁面的環境變數
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: QRCodeScanVM
    
    var body: some View {
        ZStack {
            // MARK: 相機畫面
            QrCodeScannerView(delegate: viewModel)
            
            // MARK: 右上角的關閉按鈕
            HStack {
                Spacer()
                
                VStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            .padding()
                            .background(.clear)
                    }

                    Spacer()
                }
            }
        }
    }
}

struct QRCodeScanView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScanView(viewModel: .init())
    }
}
