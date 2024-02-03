//
//  ContentView.swift
//  ChatTestapp
//
//  Created by AKSHAY VAIDYA on 01/02/24.
//

import SwiftUI
import CometChatSDK

struct ContentView:View{
    
    let uid    = "SUPERHERO1"
    let authKey = "5459553a495cd4f934250dcd09e67c87ae9a5fd0"

    
    var body:some View{
        
        VStack{
            
            Text("Akshay")
        }.onAppear(){
            
//            if CometChat.getLoggedInUser() == nil {
//              //  CometChat.logout(onSuccess: <#T##(String) -> Void##(String) -> Void##(_ Response: String) -> Void#>, onError: <#T##(CometChatException) -> Void#>)
//                CometChat.login(UID: uid, apiKey: authKey, onSuccess: { (user) in
//
//                  print("Login successful : " + user.stringValue())
//
//                }) { (error) in
//
//                  print("Login failed with error: " + error.errorDescription);
//
//                }
//
//            }
        }
    }
    
}
