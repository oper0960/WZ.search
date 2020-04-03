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
        private static let baseUrl = "https://my.callofduty.com/api/papi-client"
        public static let infomation = "\(baseUrl)/stats/cod/v1/title/mw/platform/where/gamer/id/profile/type/wz"
    }
    
    public struct MatchHistory {
        public static let matchHistory = "https://api.tracker.gg/api/v1/warzone/matches/platform/id?type=wz&next=null"
    }
}
