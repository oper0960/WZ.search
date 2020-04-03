//
//  InfomationTableViewSectionHeaderCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/23.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

class InfomationTableViewSectionHeaderCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(title: String) {
        titleLabel.text = title
    }
}
