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
            return #imageLiteral(resourceName: "battle-disable")
        case "psn":
            return #imageLiteral(resourceName: "psn-disable")
        case "xbl":
            return #imageLiteral(resourceName: "xbox-disable")
        default:
            return #imageLiteral(resourceName: "atvi-disable")
        }
    }
    
    var platformString: String {
        guard let platformSlug = leaderBoardItem?.owner?.metadata?.platformSlug else { return "" }
        let platform = Platform(platform: platformSlug)
        return platform.name
    }
    
    var avatarUrl: URL? {
        guard let urlString = leaderBoardItem?.owner?.metadata?.avatarUrl else { return nil }
        
        return URL(string: urlString) ?? nil
    }
    
    var rank: String {
        return "Rank \(leaderBoardItem?.rank?.description ?? "0")"
    }
    
    var rankingValue: String {
        return leaderBoardItem?.displayValue ?? ""
    }
    
    var matchesPlayedTitle: String {
        return leaderBoardItem?.owner?.stats?.first?.metadata?.name ?? ""
    }
    
    var matchesPlayedValue: String {
        return leaderBoardItem?.owner?.stats?.first?.value?.description ?? "0"
    }
}
