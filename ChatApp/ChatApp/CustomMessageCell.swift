//
//  CustomMessageCell.swift
//  ChatApp
//
//  Created by Arsal Jamal on 03/10/2018.
//  Copyright © 2018 abdulahad. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {

    
    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
