//
//  MatchSoloDetailTableViewCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/29.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class MatchSoloDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var platformImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(rank: String, player: MatchPlayerViewable) {
        rankLabel.text = "#\(rank)"
        platformImageView.image = player.platform
        userIdLabel.text = player.userName
    }
}
