//
//  FirebaseUserManagementApp.swift
//  FirebaseUserManagement
//
//  Created by Thibault Giraudon on 26/09/2025.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()

            let env = ProcessInfo.processInfo.environment
            let isUnitTest = env["XCTestConfigurationFilePath"] != nil

            if isUnitTest  {
                Auth.auth().useEmulator(withHost: "localhost", port: 9000)
                Firestore.firestore().useEmulator(withHost: "localhost", port: 9010)
                Storage.storage().useEmulator(withHost: "localhost", port: 9020)
                let settings = Firestore.firestore().settings
                settings.isSSLEnabled = false
                settings.cacheSettings = MemoryCacheSettings()
                Firestore.firestore().settings = settings
            }
        }
        
        return true
    }
}

@main
struct FirebaseUserManagementApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
    }
}
