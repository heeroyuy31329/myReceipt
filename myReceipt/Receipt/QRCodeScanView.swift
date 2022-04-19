//
//  QRCodeScanView.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/18.
//

import SwiftUI

struct QRCodeScanView: View {
    @StateObject var viewModel: QRCodeScanVM
    
    var body: some View {
        Text("QRCodeScanMainView")
    }
}

struct QRCodeScanView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScanView(viewModel: .init())
    }
}
