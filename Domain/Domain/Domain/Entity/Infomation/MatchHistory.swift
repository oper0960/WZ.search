//
//  MatchHistory.swift
//  Domain
//
//  Created by Gilwan Ryu on 2020/04/01.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

public protocol MatchHistoryViewable {
    var matchs: [MatchViewable] { get }
}

public protocol MatchViewable {
    var modeName: String { get }
    var mapName: String { get }
    var playerCount: String { get }
    var teamCount: String { get }
    var mapImageUrl: String { get }
    var timestamp: String { get }
    var platform: UIImage { get }
    var clanTag: String { get }
    var kills: String { get }
    var kdRatio: String { get }
    var score: String { get }
    var timePlayed: String { get }
    var headshots: String { get }
    var executions: String { get }
    var assists: String { get }
    var percentTimeMoving: String { get }
    var longestStreak: String { get }
    var scorePerMinute: String { get }
    var damageDone: String { get }
    var distanceTraveled: String { get }
    var deaths: String { get }
    var damageTaken: String { get }
    var medalXp: String { get }
    var matchXp: String { get }
    var scoreXp: String { get }
    var totalXp: String { get }
    var challengeXp: String { get }
    var teamSurvivalTime: String { get }
    var bonusXp: String { get }
    var gulagDeaths: String { get }
    var gulagKills: String { get }
    var miscXp: String { get }
    var teamPlacement: String { get }
    var damageDonePerMinute: String { get }
    var objectiveBrMissionPickupTablet: String { get }
    var objectiveBrKioskBuy: String { get }
    var objectiveBrCacheOpen: String { get }
    var objectiveLastStandKill: String { get }
    var placement: String { get }
    var plunder: String { get }
}
