//
//  MainView.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/16.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationView {
            ReceiptPeriodView(viewModel: .init())
                .navigationBarTitleDisplayMode(.inline)
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
