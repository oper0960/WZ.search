//
//  MatchHistoryTableViewCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/31.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class MatchHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var mapNameLabel: UILabel!
    @IBOutlet weak var clanTagLabel: UILabel!
    
    // Title
    @IBOutlet weak var placementTitleLabel: UILabel!
    @IBOutlet weak var playerCountTitleLabel: UILabel!
    @IBOutlet weak var scoreTitleLabel: UILabel!
    @IBOutlet weak var scorePerMinuteTitleLabel: UILabel!
    @IBOutlet weak var kdRatioTitleLabel: UILabel!
    @IBOutlet weak var assistsTitleLabel: UILabel!
    @IBOutlet weak var killsTitleLabel: UILabel!
    @IBOutlet weak var headshotsTitleLabel: UILabel!
    @IBOutlet weak var deathsTitleLabel: UILabel!
    @IBOutlet weak var totalXpTitleLabel: UILabel!
    @IBOutlet weak var damageDoneTitleLabel: UILabel!
    @IBOutlet weak var damageTakenTitleLabel: UILabel!
    @IBOutlet weak var damagePerMinuteTitleLabel: UILabel!
    @IBOutlet weak var executionsTitleLabel: UILabel!
    @IBOutlet weak var gulagKillsTitleLabel: UILabel!
    @IBOutlet weak var gulagDeathsTitleLabel: UILabel!
    @IBOutlet weak var movingTimePerTitleLabel: UILabel!
    @IBOutlet weak var plunderTitleLabel: UILabel!
    
    // Data
    @IBOutlet weak var placementLabel: UILabel!
    @IBOutlet weak var playerCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scorePerMinuteLabel: UILabel!
    @IBOutlet weak var kdRatioLabel: UILabel!
    @IBOutlet weak var assistsLabel: UILabel!
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var headshotsLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var totalXpLabel: UILabel!
    @IBOutlet weak var damageDoneLabel: UILabel!
    @IBOutlet weak var damageTakenLabel: UILabel!
    @IBOutlet weak var damagePerMiniteLabel: UILabel!
    @IBOutlet weak var executionsLabel: UILabel!
    @IBOutlet weak var gulagKillsLabel: UILabel!
    @IBOutlet weak var gulagDeathsLabel: UILabel!
    @IBOutlet weak var movingTimePerLabel: UILabel!
    @IBOutlet weak var plunderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitle() {
        placementTitleLabel.text = "placement".localized
        playerCountTitleLabel.text = "playerCount".localized
        scoreTitleLabel.text = "score".localized
        scorePerMinuteTitleLabel.text = "score/min".localized
        kdRatioTitleLabel.text = "K/D".localized
        assistsTitleLabel.text = "assists".localized
        killsTitleLabel.text = "kill".localized
        headshotsTitleLabel.text = "headshots".localized
        deathsTitleLabel.text = "death".localized
        totalXpTitleLabel.text = "totalxp".localized
        damageDoneTitleLabel.text = "damageDone".localized
        damageTakenTitleLabel.text = "damageTaken".localized
        damagePerMinuteTitleLabel.text = "damage/min".localized
        executionsTitleLabel.text = "executions".localized
        gulagKillsTitleLabel.text = "gulagKill".localized
        gulagDeathsTitleLabel.text = "gulagDeath".localized
        movingTimePerTitleLabel.text = "movingTimePer".localized
        plunderTitleLabel.text = "plunder".localized
    }
    
    func bind(match: MatchViewable) {
        modeLabel.text = match.modeName
        mapNameLabel.text = match.mapName
        clanTagLabel.text = match.clanTag
        placementLabel.text = match.placement
        playerCountLabel.text = match.playerCount
        scoreLabel.text = match.score
        scorePerMinuteLabel.text = match.scorePerMinute
        kdRatioLabel.text = match.kdRatio
        assistsLabel.text = match.assists
        killsLabel.text = match.kills
        headshotsLabel.text = match.headshots
        deathsLabel.text = match.deaths
        totalXpLabel.text = match.totalXp
        damageDoneLabel.text = match.damageDone
        damageTakenLabel.text = match.damageTaken
        damagePerMiniteLabel.text = match.damageDonePerMinute
        executionsLabel.text = match.executions
        gulagKillsLabel.text = match.gulagKills
        gulagDeathsLabel.text = match.gulagDeaths
        movingTimePerLabel.text = match.percentTimeMoving
        plunderLabel.text = match.plunder
    }
}
