//
//  MatchViewModel.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/02.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain


class MatchViewModel: MatchViewable {
    
    enum StatsType: String {
        case kills = "kills"
        case kdRatio = "kdRatio"
        case score = "score"
        case timePlayed = "timePlayed"
        case headshots = "headshots"
        case executions = "executions"
        case assists = "assists"
        case percentTimeMoving = "percentTimeMoving"
        case longestStreak = "longestStreak"
        case scorePerMinute = "scorePerMinute"
        case damageDone = "damageDone"
        case distanceTraveled = "distanceTraveled"
        case deaths = "deaths"
        case damageTaken = "damageTaken"
        case medalXp = "medalXp"
        case matchXp = "matchXp"
        case scoreXp = "scoreXp"
        case totalXp = "titalXp"
        case challengeXp = "challengeXp"
        case teamSurvivalTime = "teamSurvivalTime"
        case bonusXp = "bonusXp"
        case gulagDeaths = "gulagDeaths"
        case gulagKills = "gulagKills"
        case miscXp = "miscXp"
        case teamPlacement = "teamPlacement"
        case damageDonePerMinute = "damageDonePerMinute"
        case objectiveBrMissionPickupTablet = "objectiveBrMissionPickupTablet"
        case objectiveBrKioskBuy = "objectiveBrKioskBuy"
        case objectiveBrCacheOpen = "objectiveBrCacheOpen"
        case objectiveLastStandKill = "objectiveLastStandKill"
        case placement = "placement"
        case plunder = "plunder"
    }
    
    private var match: Match
    
    init(match: Match) {
        self.match = match
    }
    
    var timestamp: String {
        guard let timestamp = match.metadata?.timestamp else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let convertDate = dateFormatter.date(from: timestamp)
        
        let stringFormatter = DateFormatter()
        stringFormatter.locale = Locale(identifier: "ko-KR")
        stringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return stringFormatter.string(from: convertDate!)
    }
    
    var modeName: String {
        return (match.metadata?.modeName ?? "").localized
    }
    
    var mapName: String {
        return match.metadata?.mapName ?? ""
    }
    
    var playerCount: String {
        return match.metadata?.playerCount?.description ?? ""
    }
    
    var teamCount: String {
        return match.metadata?.teamCount?.description ?? ""
    }
    
    var mapImageUrl: String {
        return match.metadata?.mapImageUrl ?? ""
    }
    
    var platform: UIImage {
        guard let platform = match.segments?.first?.attributes?.platformSlug else { return UIImage() }
        switch platform {
        case "battlenet":
            return #imageLiteral(resourceName: "BattleNet")
        case "psn":
            return #imageLiteral(resourceName: "Psn")
        case "atvi":
            return #imageLiteral(resourceName: "Steam")
        default:
            return UIImage()
        }
    }
    
    var clanTag: String {
        return match.segments?.first?.metadata?.clanTag ?? ""
    }
    
    var kills: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.kills.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var kdRatio: String {
        guard let stats = match.segments?.first?.stats else { return "0.00" }
        
        for stat in stats {
            if stat.key == StatsType.kdRatio.rawValue {
                return stat.value.displayValue ?? "0.00"
            }
        }
        return "0.00"
    }
    
    var score: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.score.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var timePlayed: String {
        guard let stats = match.segments?.first?.stats else { return "00m 00s" }
        
        for stat in stats {
            if stat.key == StatsType.timePlayed.rawValue {
                return stat.value.displayValue ?? "00m 00s"
            }
        }
        return "00m 00s"
    }
    
    var headshots: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.headshots.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var executions: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.executions.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var assists: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.assists.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var percentTimeMoving: String {
        guard let stats = match.segments?.first?.stats else { return "0%" }
        
        for stat in stats {
            if stat.key == StatsType.percentTimeMoving.rawValue {
                return stat.value.displayValue ?? "0%"
            }
        }
        return "0%"
    }
    
    var longestStreak: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.longestStreak.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var scorePerMinute: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.scorePerMinute.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var damageDone: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.damageDone.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var distanceTraveled: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.distanceTraveled.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var deaths: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.deaths.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var damageTaken: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.damageTaken.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var medalXp: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.medalXp.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var matchXp: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.matchXp.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var scoreXp: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.scoreXp.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var totalXp: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.totalXp.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var challengeXp: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.challengeXp.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var teamSurvivalTime: String {
        guard let stats = match.segments?.first?.stats else { return "00m 00s" }
        
        for stat in stats {
            if stat.key == StatsType.teamSurvivalTime.rawValue {
                return stat.value.displayValue ?? "00m 00s"
            }
        }
        return "00m 00s"
    }
    
    var bonusXp: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.bonusXp.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var gulagDeaths: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.gulagDeaths.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var gulagKills: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.gulagKills.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var miscXp: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.miscXp.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var teamPlacement: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.teamPlacement.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var damageDonePerMinute: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.damageDonePerMinute.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var placement: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.placement.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var objectiveBrMissionPickupTablet: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.objectiveBrMissionPickupTablet.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var objectiveBrKioskBuy: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.objectiveBrKioskBuy.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var objectiveBrCacheOpen: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.objectiveBrCacheOpen.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var objectiveLastStandKill: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.objectiveLastStandKill.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var plunder: String {
        guard let stats = match.segments?.first?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.plunder.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
}
