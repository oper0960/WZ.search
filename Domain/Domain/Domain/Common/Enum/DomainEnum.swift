//
//  DomainEnum.swift
//  Domain
//
//  Created by Gilwan Ryu on 2020/03/18.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

public enum Platform {
    case psn
    case xbl
    case battle
    case none
    
    public var name: String {
        switch self {
        case .battle:
            return "battle"
        case .xbl:
            return "xbl"
        case .psn:
            return "psn"
        case .none:
            return "none"
        }
    }
    
    public var matchHistoryName: String {
        switch self {
        case .battle:
            return "battlenet"
        case .xbl:
            return "xbl"
        case .psn:
            return "psn"
        case .none:
            return "atvi"
        }
    }
    
    public var leaderBoardName: String {
        switch self {
        case .battle:
            return "battlenet"
        case .xbl:
            return "xbl"
        case .psn:
            return "psn"
        case .none:
            return "all"
        }
    }
    
    public init(platform: String) {
        switch platform {
        case "psn":
            self = .psn
        case "xbl":
            self = .xbl
        case "battle", "battlenet":
            self = .battle
        default:
            self = .none
        }
    }
}

public enum SearchFilter {
    // Combat
    case kills, deaths, downs, revives
    // Performance
    case kdRatio, timePlayed, score, scorePerMinute, cash, contracts
    // Game
    case wins, top5, top10, top25, totalMatches, winPercent
    // Averages
    case scorePerGame, averageLife
    // Level
    case level, totalXp
    
    public var displayName: String {
        switch self {
        case .kills:
            return "kill"
        case .deaths:
            return "death"
        case .downs:
            return "down"
        case .revives:
            return "revive"
        case .kdRatio:
            return "K/D"
        case .timePlayed:
            return "timeplayed"
        case .score:
            return "score"
        case .scorePerMinute:
            return "score/min"
        case .cash:
            return "cash"
        case .contracts:
            return "contract"
        case .wins:
            return "wins"
        case .top5:
            return "top5"
        case .top10:
            return "top10"
        case .top25:
            return "top25"
        case .totalMatches:
            return "totalmatches"
        case .winPercent:
            return "winpercent"
        case .scorePerGame:
            return "score/game"
        case .averageLife:
            return "averagelife"
        case .level:
            return "level"
        case .totalXp:
            return "totalxp"
        }
    }
    
    public var apiName: String {
        switch self {
        case .kills:
            return "kills"
        case .deaths:
            return "deaths"
        case .downs:
            return "downs"
        case .revives:
            return "revives"
        case .kdRatio:
            return "kdratio"
        case .timePlayed:
            return "timeplayed"
        case .score:
            return "score"
        case .scorePerMinute:
            return "scoreperminute"
        case .cash:
            return "cash"
        case .contracts:
            return "contracts"
        case .wins:
            return "wins"
        case .top5:
            return "top5"
        case .top10:
            return "top10"
        case .top25:
            return "top25"
        case .totalMatches:
            return "gamesplayed"
        case .winPercent:
            return "WlRatio"
        case .scorePerGame:
            return "scorepergame"
        case .averageLife:
            return "averagelife"
        case .level:
            return "level"
        case .totalXp:
            return "LevelXpTotal"
        }
    }
}
