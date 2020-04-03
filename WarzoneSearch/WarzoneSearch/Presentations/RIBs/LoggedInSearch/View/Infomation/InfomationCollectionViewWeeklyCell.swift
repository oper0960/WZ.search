//
//  InfomationCollectionViewWeeklyCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/20.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class InfomationCollectionViewWeeklyCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIViewCustom!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kdRatioLabel: UILabel!
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timePlayedLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    
    // Title Localized
    @IBOutlet weak var kdRatioTitleLabel: UILabel!
    @IBOutlet weak var killsTitleLabel: UILabel!
    @IBOutlet weak var deathsTitleLabel: UILabel!
    @IBOutlet weak var scoreTitleLabel: UILabel!
    @IBOutlet weak var timePlayedTitleLabel: UILabel!
    @IBOutlet weak var damageTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        kdRatioTitleLabel.text = "K/D".localized
        killsTitleLabel.text = "kill".localized
        deathsTitleLabel.text = "death".localized
        scoreTitleLabel.text = "score".localized
        timePlayedTitleLabel.text = "timeplayed".localized
        damageTitleLabel.text = "damage".localized
    }
    
    func bind(title: String, weekly: WeeklyViewable) {
        titleLabel.text = title
        kdRatioLabel.text = weekly.kdRatio
        killsLabel.text = weekly.kills
        deathsLabel.text = weekly.deaths
        scoreLabel.text = weekly.score
        timePlayedLabel.text = weekly.timePlayed
        damageLabel.text = weekly.damageDone
    }
}
