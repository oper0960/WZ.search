//
//  LeaderBoardFilterCollectionViewCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/09.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

class LeaderBoardFilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIViewCustom!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(title: String) {
        titleLabel.text = title
    }
    
    func setSelected() {
        backView.borderColor = #colorLiteral(red: 0.8823529412, green: 0.7254901961, blue: 0.1960784314, alpha: 1)
    }
    
    func setDeSelected() {
        backView.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
