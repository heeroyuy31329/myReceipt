//
//  ContentView.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
            aaaView
            Button ("click") {
                print("bububububub")
                let queryParams = ["paraH" : "paraH"]
//                let body = ["paraB" : "paraB"]
//                let bodyJson = try! JSONEncoder().encode(body)
                APIModel.shared.requset(method: .get, url: "/", queryParameters: queryParams/*, body: bodyJson*/) { result in
                    switch result {
                    case .success(let data):
                        let response = try! JSONDecoder().decode(String.self, from: data)
                        
                        print("結果 : \(response)")
                    case .failure(let error):
                        print("結果 : \(error)")
                    }
                }
            }
        }
    }
    
    var aaaView =
    VStack {
        Text("aaaaaaaaaa")
        Text("bbbbbbbbb")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
