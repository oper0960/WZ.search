//
//  SearchHistoryTableViewCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/27.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class SearchHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(user: UserViewable) {
        
        switch Platform(platform: user.platform!) {
        case .battle:
            platformLabel.text = "BATTLENET"
        case .psn:
            platformLabel.text = "PSN"
        case .xbl:
            platformLabel.text = "XBOX"
        case .none:
            platformLabel.text = ""
        }
        
        idLabel.text = user.id
    }
}
