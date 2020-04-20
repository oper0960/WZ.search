//
//  InfomationTableViewHeaderCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/19.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import Kingfisher

class InfomationTableViewHeaderCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIViewCustom!
    @IBOutlet weak var profileImageView: UIImageViewCustom!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var platformImageView: UIImageView!
    
    // Data Localized
    @IBOutlet weak var totalXPLabel: UILabel!
    @IBOutlet weak var levelXpProgressLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var top5Label: UILabel!
    @IBOutlet weak var top10Label: UILabel!
    @IBOutlet weak var top25Label: UILabel!
    @IBOutlet weak var revivesLabel: UILabel!
    @IBOutlet weak var gamePlayedLabel: UILabel!
    @IBOutlet weak var contractsLabel: UILabel!
    @IBOutlet weak var kdratioLabel: UILabel!
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scorePerMinuteLabel: UILabel!
    @IBOutlet weak var timaPlayedLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    
    // Title Localized
    @IBOutlet weak var totalXPTitleLabel: UILabel!
    @IBOutlet weak var levelXpProgressTitleLabel: UILabel!
    @IBOutlet weak var winsTitleLabel: UILabel!
    @IBOutlet weak var kdratioTitleLabel: UILabel!
    @IBOutlet weak var top5TitleLabel: UILabel!
    @IBOutlet weak var top10TitleLabel: UILabel!
    @IBOutlet weak var top25TitleLabel: UILabel!
    @IBOutlet weak var revivesTitleLabel: UILabel!
    @IBOutlet weak var gamePlayedTitleLabel: UILabel!
    @IBOutlet weak var contractTitleLabel: UILabel!
    @IBOutlet weak var killsTitleLabel: UILabel!
    @IBOutlet weak var deathsTitleLabel: UILabel!
    @IBOutlet weak var scoreTitleLabel: UILabel!
    @IBOutlet weak var scorePerMinuteTitleLabel: UILabel!
    @IBOutlet weak var timePlayedTitleLabel: UILabel!
    @IBOutlet weak var cashTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        totalXPTitleLabel.text = "totalxp".localized
        levelXpProgressTitleLabel.text = "levelprogress".localized
        winsTitleLabel.text = "wins".localized
        kdratioTitleLabel.text = "K/D".localized
        top5TitleLabel.text = "top5".localized
        top10TitleLabel.text = "top10".localized
        top25TitleLabel.text = "top25".localized
        revivesTitleLabel.text = "revive".localized
        gamePlayedTitleLabel.text = "gameplayed".localized
        contractTitleLabel.text = "contract".localized
        killsTitleLabel.text = "kill".localized
        deathsTitleLabel.text = "death".localized
        scoreTitleLabel.text = "score".localized
        scorePerMinuteTitleLabel.text = "score/min".localized
        timePlayedTitleLabel.text = "timeplayed".localized
        cashTitleLabel.text = "cash".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(infomation: InfomationViewable, index: Int) {
        userNameLabel.text = infomation.userId
        levelLabel.text = "Lv.\(infomation.segments[index].level)"
        platformImageView.image = infomation.platform
        totalXPLabel.text = infomation.segments[index].levelXpTotal
        winsLabel.text = infomation.segments[index].wins
        top5Label.text = infomation.segments[index].topFive
        top10Label.text = infomation.segments[index].topTen
        top25Label.text = infomation.segments[index].topTwentyFive
        levelXpProgressLabel.text = infomation.segments[index].levelXpProgression
        revivesLabel.text = infomation.segments[index].revives
        gamePlayedLabel.text = infomation.segments[index].gamesPlayed
        contractsLabel.text = infomation.segments[index].contracts
        kdratioLabel.text = infomation.segments[index].kdRatio
        killsLabel.text = infomation.segments[index].kills
        deathsLabel.text = infomation.segments[index].deaths
        scoreLabel.text = infomation.segments[index].score
        scorePerMinuteLabel.text = infomation.segments[index].scorePerMinute
        timaPlayedLabel.text = infomation.segments[index].timePlayed
        cashLabel.text = infomation.segments[index].cash
        
        if let avatarUrl = infomation.avatarUrl {
            profileImageView.kf.setImage(with: ImageResource(downloadURL: avatarUrl, cacheKey: avatarUrl.absoluteString),
                                        placeholder: nil,
                                        options: nil,
                                        progressBlock: nil)
            { result in
                
            }
        }
    }
}
