//
//  ChatCell.swift
//  ChatTestapp
//
//  Created by AKSHAY VAIDYA on 02/02/24.
//

import UIKit

class ChatCell: UITableViewCell {

  
    @IBOutlet weak var namelbl: UILabel!
    
    
    @IBOutlet weak var msglbl: UILabel!
    
    
    @IBOutlet weak var timelbl: UILabel!
    
    @IBOutlet weak var imglbl: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imglbl.layer.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(model:ConversationData, loginId:String){
        
        namelbl.text = model.conversationWith?.name ?? ""
        
        msglbl.text = model.lastMessage?.data?.text ?? ""
        timelbl.text = String(model.lastMessage?.sentAt ?? 0).getTime()
        var imgurl = ""
        if loginId == (model.lastMessage?.sender ?? "") {
            
            imgurl = model.lastMessage?.data?.entities?.receiver?.entity?.avatar ?? ""
        }
        else{
            
            imgurl = model.lastMessage?.data?.entities?.sender?.entity?.avatar ?? ""
        }
        
        
        DispatchQueue.global().async {
            
            if let url = URL(string: imgurl){
                let imgdata = try? Data(contentsOf: url)
               
                DispatchQueue.main.async {
                    
                    self.imglbl.image = UIImage(data: imgdata ?? Data())
                    
                }
            }
                
                
            
        }
    }
    
}


