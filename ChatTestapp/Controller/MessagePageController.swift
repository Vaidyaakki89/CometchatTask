//
//  MessagePageController.swift
//  ChatTestapp
//
//  Created by AKSHAY VAIDYA on 02/02/24.
//

import UIKit
import CometChatSDK

class MessagePageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    @IBOutlet weak var bottomconstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomview: UIView!
    
    var conversationdata:ConversationData?
    
    @IBOutlet weak var listview: UITableView!
    
    @IBOutlet weak var msgfield: UITextField!
    
    @IBOutlet weak var sendbtn: UIButton!
    var loginId = ""
   
    var messageData = [MessageData]()
    var viewmodel = ChatViewModel()
    var receiverId = ""
    var keyboardHeight = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginId = UserDefaults.standard.string(forKey: "loginId") ?? ""
        listview.backgroundColor = .clear
        msgfield.layer.cornerRadius = 40
        prepareTable()
        addToolItem()
        
        CometChat.messagedelegate = self
        
        viewmodel.getChatmessages(conversId: conversationdata?.conversationID ?? "", comp: {
            self.messageData = self.viewmodel.messageData
            DispatchQueue.main.async{
                self.listview.reloadData()
                self.scrollToBottom()
            }
        })
        
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardEndShow),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
    
    }
    
    func prepareTable(){
        
        listview.delegate = self
        listview.dataSource = self
        listview.separatorColor = .clear
        listview.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        listview.register(UINib(nibName: "SenderMessageCell", bundle: nil), forCellReuseIdentifier: "SenderMessageCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if messageData[indexPath.row].receiver == loginId.lowercased(){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
            cell.backgroundColor = .clear
            cell.setData(model: messageData[indexPath.row])
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderMessageCell", for: indexPath) as! SenderMessageCell
            cell.backgroundColor = .clear
            cell.setData(model: messageData[indexPath.row])
            
            return cell
            
        }
    }
    

    @IBAction func sendact(_ sender: Any) {
        
        if msgfield.text != ""{
            
            let c = SendMessageModel(category: "message", type: "text", data: SendMessageData(text: msgfield.text ?? ""), receiver: receiverId, receiverType: "user")
            let body = c.asDictionary
            
            viewmodel.sendmessage(body: body, userId: loginId, comp: {
                

                
            })
            
        }
        
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.viewmodel.messageData.count-1, section: 0)
            self.listview.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    
    

}


extension MessagePageController:CometChatMessageDelegate{
    
    
    
    func onTextMessageReceived(textMessage: TextMessage) {
      //  printContent(textMessage.stringValue())
        viewmodel.getChatmessages(conversId: conversationdata?.conversationID ?? "", comp: {
            
            self.messageData = self.viewmodel.messageData
            
            DispatchQueue.main.async{
                self.listview.reloadData()
                self.scrollToBottom()
                
            }
        })
        
    }
    
    
    func addToolItem(){
        DispatchQueue.global().async {
            var imgurl = ""
            var titlename = ""
            
            if self.loginId.lowercased() == (self.conversationdata?.lastMessage?.sender ?? "") {
                
                imgurl = self.conversationdata?.lastMessage?.data?.entities?.receiver?.entity?.avatar ?? ""
                titlename = self.conversationdata?.lastMessage?.data?.entities?.receiver?.entity?.name ?? ""
                self.receiverId = self.conversationdata?.lastMessage?.receiver ?? ""
            }
            else{
                
                imgurl = self.conversationdata?.lastMessage?.data?.entities?.sender?.entity?.avatar ?? ""
                titlename = self.conversationdata?.lastMessage?.data?.entities?.sender?.entity?.name ?? ""
                self.receiverId = self.conversationdata?.lastMessage?.sender ?? ""
            }
            
            guard let url = URL(string: imgurl) else {
                
                return
                
            }
            
            let imgdata = try? Data(contentsOf: url)
            
            DispatchQueue.main.async {
                
                let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
                
                let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
                imageView.contentMode = .scaleAspectFit
                
              //  imageView.layer.borderWidth = 1
                
                
                view1.center = logoContainer.center
                
                let titlelbl = UILabel(frame: CGRect(x: 40, y: 0, width: 150, height: 30))
                
                titlelbl.text = titlename
                
                let image = UIImage(data: imgdata ?? Data())
                imageView.image = image
                view1.addSubview(imageView)
                view1.addSubview(titlelbl)
                logoContainer.addSubview(view1)
                self.navigationItem.titleView = logoContainer
                
            }
        }
    }
    
//    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardHeight == 0{
            keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height;
            
         
                self.scrollToBottom()
                self.bottomconstraint.constant =  self.keyboardHeight
                
                
        
            
        }
    }
    
    @objc func keyboardEndShow(notification: NSNotification) {
         keyboardHeight = 0
      
             self.scrollToBottom()
             self.bottomconstraint.constant =  0
           
     
    }
    
    
}
