//
//  myReceiptApp.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/14.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin
import AWSAPIPlugin

@main
struct myReceiptApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 顯示log
        Amplify.Logging.logLevel = .verbose
        
        // 初始化Amplify
        do {
            try Amplify.add(plugin:AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSAPIPlugin())
            try Amplify.configure()
        } catch {
            print("Amplify init error \(error)")
        }
        
        
        return true
    }
}
