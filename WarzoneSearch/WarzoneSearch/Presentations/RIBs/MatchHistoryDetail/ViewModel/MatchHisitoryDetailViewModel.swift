//
//  MatchHisitoryDetailViewModel.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/27.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class MatchTeam: MatchTeamViewable {
    var rank: Int
    var team = [MatchPlayerViewable]()
    
    init(rank: Int, team: [MatchPlayerViewable]) {
        self.rank = rank
        self.team = team
    }
}

class MatchHisitoryDetailViewModel: MatchHistoryDetailViewable {
    
    enum PlayersType {
        case solo, team, none
        
        init(mode: String) {
            switch mode {
            case "":
                self = .none
            case "Plunder Solos", "BR Solos":
                self = .solo
            default:
                self = .team
            }
        }
    }
    
    private var matchHistoryData: MatchHistoryDetailData?
    
    init(matchHistoryData: MatchHistoryDetailData) {
        self.matchHistoryData = matchHistoryData
    }
    
    init() {
        
    }
    
    var mapImageUrl: URL? {
        
        guard let urlString = matchHistoryData?.metadata?.mapImageUrl else { return nil }
        
        return URL(string: urlString)
    }
    
    var modeName: String {
        return (matchHistoryData?.metadata?.modeName ?? "").localized
    }
    
    var mapName: String {
        return matchHistoryData?.metadata?.mapName ?? ""
    }
    
    var timestamp: String {
        guard let timestamp = matchHistoryData?.metadata?.timestamp else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let convertDate = dateFormatter.date(from: timestamp)
        
        let stringFormatter = DateFormatter()
        stringFormatter.locale = Locale(identifier: "ko-KR")
        stringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return stringFormatter.string(from: convertDate!)
    }
    
    var playerCount: String {
        return matchHistoryData?.metadata?.playerCount?.description ?? ""
    }
    
    var teamCount: String {
        return matchHistoryData?.metadata?.teamCount?.description ?? ""
    }
    
    var isSolo: Bool {
        return PlayersType(mode: matchHistoryData?.metadata?.modeName ?? "") == .solo
    }
    
    var players: [MatchTeamViewable]? {
        guard let players = matchHistoryData?.segments else { return nil }
        
        var teams = [MatchTeamViewable]()
        
        for player in players {
            guard teams.count > 0 else {
                teams.append(MatchTeam(rank: player.metadata?.placement?.value ?? 0, team: [MatchPlayerViewModel(player: player)]))
                continue
            }
            
            guard var lastTeam = teams.last else { continue }
            
            if lastTeam.rank == player.metadata?.placement?.value ?? 0 {
                lastTeam.team.append(MatchPlayerViewModel(player: player))
            } else {
                teams.append(MatchTeam(rank: player.metadata?.placement?.value ?? 0, team: [MatchPlayerViewModel(player: player)]))
            }
        }
        
        guard teams.count > 0 else { return nil }
        
        return teams
    }
}

class MatchPlayerViewModel: MatchPlayerViewable {
    
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
        case damageDonePerMinute = "damageDonePerMinute"
    }
    
    private var player: DetailSegment?
    
    init(player: DetailSegment) {
        self.player = player
    }
    
    init() {
        
    }
    
    var userName: String {
        return player?.attributes?.platformUserIdentifier ?? ""
    }
    
    var platform: UIImage {
        guard let platform = player?.attributes?.platformSlug else { return UIImage() }
        switch platform {
        case "battlenet":
            return #imageLiteral(resourceName: "BattleNet")
        case "psn":
            return #imageLiteral(resourceName: "Psn")
        case "xbl":
            return #imageLiteral(resourceName: "xbox-disable")
        default:
            return UIImage()
        }
    }
    
    var kills: String {
        guard let stats = player?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.kills.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var kdRatio: String {
        guard let stats = player?.stats else { return "0.00" }
        
        for stat in stats {
            if stat.key == StatsType.kdRatio.rawValue {
                return stat.value.displayValue ?? "0.00"
            }
        }
        return "0.00"
    }
    
    var score: String {
        guard let stats = player?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.score.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var timePlayed: String {
        guard let stats = player?.stats else { return "00m 00s" }
        
        for stat in stats {
            if stat.key == StatsType.timePlayed.rawValue {
                return stat.value.displayValue ?? "00m 00s"
            }
        }
        return "00m 00s"
    }
    
    var headshots: String {
        guard let stats = player?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.headshots.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var executions: String {
        guard let stats = player?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.executions.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var assists: String {
        guard let stats = player?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.assists.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var percentTimeMoving: String {
        guard let stats = player?.stats else { return "0%" }
        
        for stat in stats {
            if stat.key == StatsType.percentTimeMoving.rawValue {
                return stat.value.displayValue ?? "0%"
            }
        }
        return "0%"
    }
    
    var longestStreak: String {
        guard let stats = player?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.longestStreak.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var scorePerMinute: String {
        guard let stats = player?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.scorePerMinute.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var damageDone: String {
        guard let stats = player?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.damageDone.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var distanceTraveled: String {
        guard let stats = player?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.distanceTraveled.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var deaths: String {
        guard let stats = player?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.deaths.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var damageTaken: String {
        guard let stats = player?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.damageTaken.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
    
    var damageDonePerMinute: String {
        guard let stats = player?.stats else { return "0" }
        
        for stat in stats {
            if stat.key == StatsType.damageDonePerMinute.rawValue {
                return stat.value.displayValue ?? "0"
            }
        }
        return "0"
    }
}
