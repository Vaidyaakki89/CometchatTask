//
//  Utility.swift
//  ChatTestapp
//
//  Created by AKSHAY VAIDYA on 02/02/24.
//

import Foundation
import UIKit



class Networkreq{
    
    static let baseurl = "https://252027a49292bd71.api-in.cometchat.io/v3"
}

enum Apiendpoints:String{
    
    case conversation = "conversations"
    
    case message = "messages"
}

extension Encodable {
    var asDictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}



extension String{
    
    
    
    func getTime()->String{
        
        var formatter = DateFormatter()
        
        let timestamp = CLong(self) ?? 0
        
        let date = NSDate(timeIntervalSince1970: TimeInterval(timestamp/1000))
        
        formatter.dateFormat = "h:mm a"
        
        var str = formatter.string(from: date as Date)
        
        
        return str
        
    }
    
    
}
  
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
