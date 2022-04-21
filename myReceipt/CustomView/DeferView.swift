//
//  DeferView.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/19.
//

import Foundation
import SwiftUI

/// 可以用此view來避免目標view被提早初始化，讓其在用到時才進行初始化
struct DeferView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        content()          // << everything is created here
    }
}
