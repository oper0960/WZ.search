//
//  PlayerViewModel.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/09.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class PlayerViewModel: PlayerViewable {
    
    private var leaderBoardItem: Item?
    
    init(item: Item) {
        self.leaderBoardItem = item
    }
    
    init() {
        
    }
    
    var id: String {
        return leaderBoardItem?.owner?.metadata?.platformUserIdentifier ?? "No Identifier"
    }
    
    var platform: UIImage {
        guard let platform = leaderBoardItem?.owner?.metadata?.platformSlug else { return UIImage() }
        switch platform {
        case "battlenet":
            return #imageLiteral(resourceName: "BattleNet")
        case "psn":
            return #imageLiteral(resourceName: "Psn")
        case "xbl":
            return #imageLiteral(resourceName: "Xbox")
        default:
            return UIImage()
        }
    }
    
    var avatarUrl: String {
        return leaderBoardItem?.owner?.metadata?.avatarUrl ?? ""
    }
    
    var rank: String {
        return leaderBoardItem?.rank?.description ?? "0"
    }
    
    var matchesPlayedValue: String {
        return leaderBoardItem?.owner?.stats?.first?.value?.description ?? "0"
    }
}
