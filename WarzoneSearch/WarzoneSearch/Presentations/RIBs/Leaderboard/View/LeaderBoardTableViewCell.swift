//
//  LeaderBoardTableViewCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/09.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import Kingfisher

class LeaderBoardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var matchesTitleLabel: UILabel!
    @IBOutlet weak var matchesLabel: UILabel!
    @IBOutlet weak var filterTitleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var platformImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bind(player: PlayerViewable, rankFilter: String) {
        rankLabel.text = player.rank
        idLabel.text = player.id
        platformImageView.image = player.platform
        filterTitleLabel.text = rankFilter
        valueLabel.text = player.rankingValue
        matchesTitleLabel.text = "totalmatches".localized
        matchesLabel.text = player.matchesPlayedValue
        
        if let avatarUrl = player.avatarUrl {
            avatarImageView.kf.setImage(with: ImageResource(downloadURL: avatarUrl, cacheKey: avatarUrl.absoluteString),
                                        placeholder: nil,
                                        options: nil,
                                        progressBlock: nil)
            { result in
                
            }
        }
    }
}
