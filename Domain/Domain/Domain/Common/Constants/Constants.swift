//
//  Constants.swift
//  Domain
//
//  Created by Gilwan Ryu on 2020/03/03.
//  Copyright © 2020 Gilwan Ryu. All rights reserved.
//

import Foundation

public struct Constants {
    
    public struct Infomation {
        public static let infomation = "https://api.tracker.gg/api/v2/warzone/standard/profile/platform/id"
    }
    
    public struct MatchHistory {
        public static let profile = "https://api.tracker.gg/api/v2/warzone/standard/profile/platform/id"
        public static let matchHistory = "https://api.tracker.gg/api/v1/warzone/matches/platform/id?type=wz&next=null"
        public static let matchHistoryDetail = "https://api.tracker.gg/api/v1/warzone/matches/matchid"
        public static let leaderboard = "https://api.tracker.gg/api/v1/warzone/standard/leaderboards?type=stats&platform=where&board=filter&skip=0&take=100"
    }
}
 
