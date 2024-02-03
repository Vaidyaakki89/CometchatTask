//
//  MessageCell.swift
//  ChatTestapp
//
//  Created by AKSHAY VAIDYA on 02/02/24.
//

import UIKit

class MessageCell: UITableViewCell {

  
    
    @IBOutlet weak var msglbl: UILabel!
    
    @IBOutlet weak var timelbl: UILabel!
    
    
    @IBOutlet weak var holderview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderview.layer.cornerRadius = 15
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(model:MessageData){
        
        msglbl.text = model.data?.text ?? ""
        timelbl.text = String(model.sentAt ?? 0).getTime()
    }
}
