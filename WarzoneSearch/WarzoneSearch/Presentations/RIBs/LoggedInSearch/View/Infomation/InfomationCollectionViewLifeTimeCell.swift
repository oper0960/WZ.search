//
//  InfomationCollectionViewLifeTimeCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/23.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class InfomationCollectionViewLifeTimeCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var top5Label: UILabel!
    @IBOutlet weak var top10Label: UILabel!
    @IBOutlet weak var kdRatioLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timePlayedLabel: UILabel!
    
    // Title Localized
    @IBOutlet weak var winsTitleLabel: UILabel!
    @IBOutlet weak var top5TitleLabel: UILabel!
    @IBOutlet weak var top10TitleLabel: UILabel!
    @IBOutlet weak var kdRatioTitleLabel: UILabel!
    @IBOutlet weak var scoreTitleLabel: UILabel!
    @IBOutlet weak var timePlayedTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        kdRatioTitleLabel.text = "K/D".localized
        winsTitleLabel.text = "wins".localized
        top5TitleLabel.text = "top5".localized
        scoreTitleLabel.text = "score".localized
        timePlayedTitleLabel.text = "timeplayed".localized
        top10TitleLabel.text = "top10".localized
    }
    
    func bind(title: String, segment: SegmentViewable) {
        titleLabel.text = title
        winsLabel.text = segment.wins
        top5Label.text = segment.topFive
        top10Label.text = segment.topTen
        kdRatioLabel.text = segment.kdRatio
        scoreLabel.text = segment.score
        timePlayedLabel.text = segment.timePlayed
    }
}
