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
    
    var soloPlayers: [MatchPlayerViewable]? {
        
        switch PlayersType(mode: matchHistoryData?.metadata?.modeName ?? "") {
        case .solo:
            guard let players = matchHistoryData?.segments else { return nil }
            
            var array = [MatchPlayerViewModel]()
            
            for player in players {
                array.append(MatchPlayerViewModel(player: player))
            }
            
            guard array.count > 0 else { return nil }
            
            return array
        default:
            return nil
        }
    }
    
    var teamPlayers: [MatchTeamViewable]? {
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
}
