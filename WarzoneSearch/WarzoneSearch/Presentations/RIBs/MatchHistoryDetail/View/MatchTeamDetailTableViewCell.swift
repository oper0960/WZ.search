//
//  MatchTeamDetailTableViewCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/29.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class MatchTeamDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var platformImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var expandableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dropdownImageView: UIImageView!
    
    // Title
    @IBOutlet weak var kdRatioTitleLabel: UILabel!
    @IBOutlet weak var killsTitleLabel: UILabel!
    @IBOutlet weak var headshotsTitleLabel: UILabel!
    @IBOutlet weak var timePlayedTitleLabel: UILabel!
    @IBOutlet weak var movingPerTitleLabel: UILabel!
    @IBOutlet weak var damageDoneTitleLabel: UILabel!
    @IBOutlet weak var damagePerMinuteTitleLabel: UILabel!
    @IBOutlet weak var scoreTitleLabel: UILabel!
    @IBOutlet weak var deathsTitleLabel: UILabel!
    @IBOutlet weak var assistsTitleLabel: UILabel!
    @IBOutlet weak var executionsTitleLabel: UILabel!
    @IBOutlet weak var longestStreakTitleLabel: UILabel!
    @IBOutlet weak var damageTakenTitleLabel: UILabel!
    @IBOutlet weak var distanceTraveledTitleLabel: UILabel!
    @IBOutlet weak var scorePerMinuteTitleLabel: UILabel!
    
    // Data
    @IBOutlet weak var kdRatioLabel: UILabel!
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var headshotsLabel: UILabel!
    @IBOutlet weak var timePlayedLabel: UILabel!
    @IBOutlet weak var movingPerLabel: UILabel!
    @IBOutlet weak var damageDoneLabel: UILabel!
    @IBOutlet weak var damagePerMinuteLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var assistsLabel: UILabel!
    @IBOutlet weak var executionsLabel: UILabel!
    @IBOutlet weak var longestStreakLabel: UILabel!
    @IBOutlet weak var damageTakenLabel: UILabel!
    @IBOutlet weak var distanceTraveledLabel: UILabel!
    @IBOutlet weak var scorePerMinuteLabel: UILabel!
    
    var isRotation: Bool = false {
           didSet {
               if isRotation {
                   dropdownImageView.transform = CGAffineTransform(rotationAngle: -90 * CGFloat.pi/180)
                   dropdownImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
               } else {
                   dropdownImageView.transform = CGAffineTransform(rotationAngle: -90 * CGFloat.pi/180)
                   dropdownImageView.transform = CGAffineTransform(rotationAngle: 0)
               }
           }
       }
    
    var isExpanded: Bool = false {
        didSet {
            if isExpanded {
                expandableViewHeight.constant = 508
                UIView.animate(withDuration: 0.25, animations: {
                    self.isRotation = true
                })
            } else {
                expandableViewHeight.constant = 0
                UIView.animate(withDuration: 0.25, animations: {
                    self.isRotation = false
                })
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setTitle() {
        kdRatioTitleLabel.text = "K/D".localized
        killsTitleLabel.text = "kill".localized
        headshotsTitleLabel.text = "headshots".localized
        timePlayedTitleLabel.text = "timeplayed".localized
        movingPerTitleLabel.text = "movingTimePer".localized
        damageDoneTitleLabel.text = "damageDone".localized
        damagePerMinuteTitleLabel.text = "damage/min".localized
        scoreTitleLabel.text = "score".localized
        deathsTitleLabel.text = "death".localized
        assistsTitleLabel.text = "assists".localized
        executionsTitleLabel.text = "executions".localized
        longestStreakTitleLabel.text = "longestStreak".localized
        damageTakenTitleLabel.text = "damageTaken".localized
        distanceTraveledTitleLabel.text = "distanceTraveled".localized
        scorePerMinuteTitleLabel.text = "score/min".localized
    }
    
    func bind(player: MatchPlayerViewable) {
        platformImageView.image = player.platform
        userIdLabel.text = player.userName
        kdRatioLabel.text = player.kdRatio
        killsLabel.text = player.kills
        headshotsLabel.text = player.headshots
        timePlayedLabel.text = player.timePlayed
        movingPerLabel.text = player.percentTimeMoving
        damageDoneLabel.text = player.damageDone
        damagePerMinuteLabel.text = player.damageDonePerMinute
        scoreLabel.text = player.score
        deathsLabel.text = player.deaths
        assistsLabel.text = player.assists
        executionsLabel.text = player.executions
        longestStreakLabel.text = player.longestStreak
        damageTakenLabel.text = player.damageTaken
        distanceTraveledLabel.text = player.distanceTraveled
        scorePerMinuteLabel.text = player.scorePerMinute
    }
}
