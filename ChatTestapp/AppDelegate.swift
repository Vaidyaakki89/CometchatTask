//
//  AppDelegate.swift
//  ChatTestapp
//
//  Created by AKSHAY VAIDYA on 01/02/24.
//

import UIKit
import CometChatSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appId: String = "252027a49292bd71"
       let region: String = "in"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let mySettings = AppSettings.AppSettingsBuilder()
                                      .subscribePresenceForAllUsers()
                                      .setRegion(region: region)
                                      .autoEstablishSocketConnection(true)
                                      .build()
                
          CometChat.init(appId: appId ,appSettings: mySettings,onSuccess: { (isSuccess) in
                    if (isSuccess) {
                        print("CometChat Pro SDK intialise successfully.")
                    }
                }) { (error) in
                        print("CometChat Pro SDK failed intialise with error: \(error.errorDescription)")
                }
        
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

