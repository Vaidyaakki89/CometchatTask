//
//  LoginController.swift
//  ChatTestapp
//
//  Created by AKSHAY VAIDYA on 02/02/24.
//

import UIKit
import CometChatSDK

class LoginController: UIViewController {
    
    @IBOutlet weak var textfield: UITextField!
    //  let uid  = "SUPERHERO1"
    let authKey = "5459553a495cd4f934250dcd09e67c87ae9a5fd0"
    
    @IBOutlet weak var loginbtn: UIButton!
    
    var keyboardheight = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginbtn.layer.cornerRadius = 25
        
        
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
    
    
    @IBAction func loginaction(_ sender: Any) {
        
        let uid = (textfield.text ?? "").uppercased()
        
        CometChat.login(UID: uid, apiKey: authKey, onSuccess: { (user) in
            
            print("Login successful : " + user.stringValue())
            UserDefaults.standard.set(uid, forKey: "loginId")
            
            DispatchQueue.main.async{
                let chatVc = self.storyboard?.instantiateViewController(withIdentifier: "ChatpageController") as! ChatpageController
                
                self.navigationController?.pushViewController(chatVc, animated: true)
            }
            
        }) { (error) in
            
            print("Login failed with error: " + error.errorDescription);
            
        }
        
    }
    
    
    //
    @objc func keyboardWillShow(notification: NSNotification) {
        
        
        if keyboardheight == 0{
            keyboardheight = 200
            view.frame.origin.y = view.frame.origin.y - 200
            
    }
    

            
           
        }
        
        @objc func keyboardEndShow(notification: NSNotification) {
            if keyboardheight != 0{
                view.frame.origin.y = view.frame.origin.y + 200
                keyboardheight = 0
                
            }
        }
    
    
}
