//
//  ChatViewModel.swift
//  ChatTestapp
//
//  Created by AKSHAY VAIDYA on 02/02/24.
//

import Foundation

class ChatViewModel{
//https://252027a49292bd71.api-in.cometchat.io/v3/conversations
    
    var chatuserData = [ConversationData]()
    var messageData = [MessageData]()
    
    func getUserConversation(userId:String, comp:(()->())? = nil){
        
        guard let url = URL(string: "\(Networkreq.baseurl)/\(Apiendpoints.conversation.rawValue)")
        else{return}
        
        var urlreq = URLRequest(url: url)
        urlreq.httpMethod = "GET"
        urlreq.setValue("ccac68b80cfe3f7035992fc442a763398413a583", forHTTPHeaderField: "apikey")
        urlreq.setValue(userId, forHTTPHeaderField: "onBehalfOf")
        
        URLSession.shared.dataTask(with: urlreq){data, _, _ in
            
            print(data)
            
            guard let jsondata = data, let model = try? JSONDecoder().decode(ConversationModel.self, from: jsondata) else{
                
                return
            }
            
            print(model)
            
            self.chatuserData = model.data.filter({$0.conversationType != "group"})
            
            comp?()
            
        }.resume()
        
    }
    
    
    func getChatmessages(conversId:String,comp:(()->())? = nil){
        
        guard let url = URL(string: "\(Networkreq.baseurl)/\(Apiendpoints.message.rawValue)")
        else{return}
        
        var urlreq = URLRequest(url: url)
        urlreq.httpMethod = "GET"
        urlreq.setValue("ccac68b80cfe3f7035992fc442a763398413a583", forHTTPHeaderField: "apikey")
//        urlreq.setValue("SUPERHERO1", forHTTPHeaderField: "onBehalfOf")
        
        URLSession.shared.dataTask(with: urlreq){data, _, _ in
            
            print(data)
            
            guard let jsondata = data, let model = try? JSONDecoder().decode(MessageModel.self, from: jsondata) else{
                
                return
            }
            
            print(model)
            
        self.messageData = model.data.filter({$0.conversationID == conversId})
            
            comp?()
            
        }.resume()
        
    }
    
    func sendmessage(body:[String:Any],userId:String, comp:(()->())? = nil){
        
        guard let url = URL(string: "\(Networkreq.baseurl)/\(Apiendpoints.message.rawValue)")
        else{return}
        
        var urlreq = URLRequest(url: url)
        
        let jsonbody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        urlreq.httpMethod = "POST"
        urlreq.httpBody = jsonbody
        urlreq.setValue("ccac68b80cfe3f7035992fc442a763398413a583", forHTTPHeaderField: "apikey")
       urlreq.setValue(userId, forHTTPHeaderField: "onBehalfOf")
        urlreq.setValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: urlreq){data, _, _ in
            
            print(data)
            
            guard let jsondata = data else{
                
                return
            }
            
         //   print(model)
            
     //   self.messageData = model.data.filter({$0.conversationID == conversId})
            
            comp?()
            
        }.resume()
        
    }
    
}


