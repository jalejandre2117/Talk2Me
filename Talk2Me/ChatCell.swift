//
//  ChatCell.swift
//  Talk2Me
//
//  Created by Jorge Alejandre on 12/9/18.
//  Copyright © 2018 Jorge Alejandre. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var chatMessage: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
