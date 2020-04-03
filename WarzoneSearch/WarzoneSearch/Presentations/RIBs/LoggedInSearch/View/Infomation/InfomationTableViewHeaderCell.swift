//
//  InfomationTableViewHeaderCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/19.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class InfomationTableViewHeaderCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIViewCustom!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var platformImageView: UIImageView!
    @IBOutlet weak var totalXPLabel: UILabel!
    @IBOutlet weak var remainderXPLabel: UILabel!
    @IBOutlet weak var gainedXPLabel: UILabel!
    
    // Title Localized
    @IBOutlet weak var totalXPTitleLabel: UILabel!
    @IBOutlet weak var remainderXPTitleLabel: UILabel!
    @IBOutlet weak var gainedXPTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        totalXPTitleLabel.text = "totalxp".localized
        remainderXPTitleLabel.text = "remainderxp".localized
        gainedXPTitleLabel.text = "gainedxp".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(infomation: InfomationViewable) {
        userNameLabel.text = infomation.userName
        levelLabel.text = "Lv.\(infomation.level)"
        platformImageView.image = infomation.platform
        totalXPLabel.text = infomation.totalXp
        remainderXPLabel.text = infomation.levelXpRemainder
        gainedXPLabel.text = infomation.levelXpGained
    }
}
