//
//  ChatpageController.swift
//  ChatTestapp
//
//  Created by AKSHAY VAIDYA on 02/02/24.
//

import UIKit
import CometChatSDK

class ChatpageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

   
    @IBOutlet weak var listview: UITableView!
    
    var viewmodel = ChatViewModel()
    
    var loginId = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginId = UserDefaults.standard.string(forKey: "loginId") ?? ""
        
        prepareTable()
        
        let logoutbtn =  UIBarButtonItem(title: "Log out", style: .done, target: self, action: #selector(logout))
      
       

        navigationItem.rightBarButtonItems = [logoutbtn]
        navigationItem.hidesBackButton = true
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        
        viewmodel.getUserConversation(userId: loginId){
            
            DispatchQueue.main.async{
                self.listview.reloadData()
                
            }
        }
        
    }
    
    
    func prepareTable(){
        
        listview.delegate = self
        listview.dataSource = self
        listview.separatorColor = .clear
        listview.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
        
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.chatuserData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        cell.setData(model: viewmodel.chatuserData[indexPath.row], loginId: loginId.lowercased())
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MessagePageController") as! MessagePageController
        vc.conversationdata = viewmodel.chatuserData[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        
    }


}


extension ChatpageController{
    
    @objc func logout(){
        
        CometChat.logout(onSuccess: {msg in
            
            print(msg)
            self.switchtoLogin()
            
        }, onError: {err in
            
            print(err.description)
        })
    }
    
    func switchtoLogin(){
        
        UserDefaults.standard.removeObject(forKey: "loginId")
        //   UserDefaults.standard.set(false, forKey: "isLogin")
        UserDefaults.standard.synchronize()
        
        
        let scenedelegate = (self.view.window?.windowScene?.delegate) as! SceneDelegate
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginController
        
        scenedelegate.window?.rootViewController = UINavigationController(rootViewController: vc)
    }
    
}
