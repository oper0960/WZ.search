//
//  InfomationCodable.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

struct InfomationCodable: Codable {
    var infomation: Infomation
    
    private enum CodingKeys: String, CodingKey {
        case infomation = "data"
    }
}

struct Infomation: Codable {
    var title: String?
    var platform: String?
    var userName: String?
    var type: String?
    var level: Double?
    var maxLavel: Double?
    var levelXpRemainder: Double?
    var levelXpGained: Double?
    var prestige: Double?
    var prestigeId: Double?
    var maxPrestige: Double?
    var totalXp: Double?
    var paragonRank: Double?
    var paragonId: Double?
    var s: Double?
    var lifetime: Lifetime?
    var weekly: Weekly?
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case platform = "platform"
        case userName = "username"
        case type = "type"
        case level = "level"
        case maxLavel = "maxLavel"
        case levelXpRemainder = "levelXpRemainder"
        case levelXpGained = "levelXpGained"
        case prestige = "prestige"
        case prestigeId = "prestigeId"
        case maxPrestige = "maxPrestige"
        case totalXp = "totalXp"
        case paragonRank = "paragonRank"
        case paragonId = "paragonId"
        case s = "s"
        case lifetime = "lifetime"
        case weekly = "weekly"
    }
}

// MARK: LifeTime
struct Lifetime: Codable {

    let mode: Mode
    
//    let all: All
//    let map: Map
//    let itemData: ItemData
//    let scorestreakData: ScorestreakData
//    let accoladeData: AccoladeData

    private enum CodingKeys: String, CodingKey {
        case mode = "mode"
        
//        case all = "all"
//        case map = "map"
//        case itemData = "itemData"
//        case scorestreakData = "scorestreakData"
//        case accoladeData = "accoladeData"
    }
}

// MARK: All
struct All: Codable {

    let properties: Properties?

    private enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

struct Properties: Codable {
    
    let recordLongestWinStreak: Double?
    let recordXpInAMatch: Double?
    let accuracy: Double?
    let bestTotalXp: Double?
    let losses: Double?
    let totalGamesPlayed: Double?
    let score: Double?
    let winLossRatio: Double?
    let totalShots: Double?
    let bestScoreXp: Double?
    let gamesPlayed: Double?
    let bestSquardKills: Double?
    let bestSguardWave: Double?
    let bestConfirmed: Double?
    let deaths: Double?
    let wins: Double?
    let bestSquardCrates: Double?
    let kdRatio: Double?
    let bestAssists: Double?
    let bestFieldgoals: Double?
    let bestScore: Double?
    let recordDeathsInAMatch: Double?
    let scorePerGame: Double?
    let bestSPM: Double?
    let bestKillChains: Double?
    let recordKillsInAMatch: Double?
    let suicides: Double?
    let wlRatio: Double?
    let currentWinStreak: Double?
    let bestMatchBonusXp: Double?
    let bestMatchXp: Double?
    let bestSguardWeaponLevel: Double?
    let bestKD: Double?
    let kills: Double?
    let bestKillsAsInfected: Double?
    let bestReturns: Double?
    let bestStabs: Double?
    let bestKillsAsSurvivor: Double?
    let timePlayedTotal: Double?
    let bestDestructions: Double?
    let headshots: Double?
    let bestRescues: Double?
    let assists: Double?
    let ties: Double?
    let recordKillStreak: Double?
    let bestPlants: Double?
    let misses: Double?
    let bestDamage: Double?
    let bestSetbacks: Double?
    let bestTouchdowns: Double?
    let scorePerMinute: Double?
    let bestDeaths: Double?
    let bestMedalXp: Double?
    let bestDefends: Double?
    let bestSquardRevives: Double?
    let bestKills: Double?
    let bestDefuses: Double?
    let bestCaptures: Double?
    let hits: Double?
    let bestMiscXp: Double?
    let bestKillStreak: Double?
    let bestDenied: Double?
    
    private enum CodingKeys: String, CodingKey {
        case recordLongestWinStreak = "recordLongestWinStreak"
        case recordXpInAMatch = "recordXpInAMatch"
        case accuracy = "accuracy"
        case bestTotalXp = "bestTotalXp"
        case losses = "losses"
        case totalGamesPlayed = "totalGamesPlayed"
        case score = "score"
        case winLossRatio = "winLossRatio"
        case totalShots = "totalShots"
        case bestScoreXp = "bestScoreXp"
        case gamesPlayed = "gamesPlayed"
        case bestSquardKills = "bestSquardKills"
        case bestSguardWave = "bestSguardWave"
        case bestConfirmed = "bestConfirmed"
        case deaths = "deaths"
        case wins = "wins"
        case bestSquardCrates = "bestSquardCrates"
        case kdRatio = "kdRatio"
        case bestAssists = "bestAssists"
        case bestFieldgoals = "bestFieldgoals"
        case bestScore = "bestScore"
        case recordDeathsInAMatch = "recordDeathsInAMatch"
        case scorePerGame = "scorePerGame"
        case bestSPM = "bestSPM"
        case bestKillChains = "bestKillChains"
        case recordKillsInAMatch = "recordKillsInAMatch"
        case suicides = "suicides"
        case wlRatio = "wlRatio"
        case currentWinStreak = "currentWinStreak"
        case bestMatchBonusXp = "bestMatchBonusXp"
        case bestMatchXp = "bestMatchXp"
        case bestSguardWeaponLevel = "bestSguardWeaponLevel"
        case bestKD = "bestKD"
        case kills = "kills"
        case bestKillsAsInfected = "bestKillsAsInfected"
        case bestReturns = "bestReturns"
        case bestStabs = "bestStabs"
        case bestKillsAsSurvivor = "bestKillsAsSurvivor"
        case timePlayedTotal = "timePlayedTotal"
        case bestDestructions = "bestDestructions"
        case headshots = "headshots"
        case bestRescues = "bestRescues"
        case assists = "assists"
        case ties = "ties"
        case recordKillStreak = "recordKillStreak"
        case bestPlants = "bestPlants"
        case misses = "misses"
        case bestDamage = "bestDamage"
        case bestSetbacks = "bestSetbacks"
        case bestTouchdowns = "bestTouchdowns"
        case scorePerMinute = "scorePerMinute"
        case bestDeaths = "bestDeaths"
        case bestMedalXp = "bestMedalXp"
        case bestDefends = "bestDefends"
        case bestSquardRevives = "bestSquardRevives"
        case bestKills = "bestKills"
        case bestDefuses = "bestDefuses"
        case bestCaptures = "bestCaptures"
        case hits = "hits"
        case bestMiscXp = "bestMiscXp"
        case bestKillStreak = "bestKillStreak"
        case bestDenied = "bestDenied"
    }
}



// MARK: Mode
struct Mode: Codable {

    let brDmz: BrDmz?
    let br: Br?
    let brAll: BrAllMode?

    private enum CodingKeys: String, CodingKey {
        case brDmz = "br_dmz"
        case br = "br"
        case brAll = "br_all"
    }
}

// MARK: BrDmz
struct BrDmz: Codable {

    let properties: ModeProperties?

    private enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: Br
struct Br: Codable {

    let properties: ModeProperties?

    private enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: BrAll
struct BrAllMode: Codable {

    let properties: ModeProperties?

    private enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: Mode Properties
struct ModeProperties: Codable {

    let wins: Double?
    let kills: Double?
    let kdRatio: Double?
    let downs: Double?
    let topTwentyFive: Double?
    let topTen: Double?
    let contracts: Double?
    let revives: Double?
    let topFive: Double?
    let score: Double?
    let gamesPlayed: Double?
    let timePlayed: Double?
    let scorePerMinute: Double?
    let cash: Double?
    let deaths: Double?
    
    private enum CodingKeys: String, CodingKey {
        case wins, kills, kdRatio, timePlayed, downs
        case topTwentyFive, topTen, contracts, revives, topFive
        case score, gamesPlayed, scorePerMinute, deaths, cash
    }
}

// MARK: Weekly
struct Weekly: Codable {

    let all: WeeklyAll
    let mode: WeeklyMode

    private enum CodingKeys: String, CodingKey {
        case all = "all"
        case mode = "mode"
    }
}

// MARK: Weekly All
struct WeeklyAll: Codable {

    let properties: WeeklyProperties?

    private enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: Mode
struct WeeklyMode: Codable {

    let brDmz: WeeklyBrDmz38?
    let br25: WeeklyBr25?
    let br87: WeeklyBr87?
    let brAll: WeeklyBrAllMode?

    private enum CodingKeys: String, CodingKey {
        case brDmz = "br_dmz_38"
        case br25 = "br_25"
        case br87 = "br_87"
        case brAll = "br_all"
    }
}

// MARK: Weekly BrDmz38
struct WeeklyBrDmz38: Codable {

    let properties: WeeklyProperties?

    private enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: Weekly Br25
struct WeeklyBr25: Codable {

    let properties: WeeklyProperties?

    private enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: Weekly Br87
struct WeeklyBr87: Codable {

    let properties: WeeklyProperties?

    private enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: Weekly BrAll
struct WeeklyBrAllMode: Codable {

    let properties: WeeklyProperties?

    private enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}

// MARK: Weekly Properties
struct WeeklyProperties: Codable {
    let kills: Double?
    let objectiveTeamWiped: Double?
    let avgLifeTime: Double?
    let score: Double?
    let headshots: Double?
    let assists: Double?
    let killsPerGame: Double?
    let scorePerMinute: Double?
    let scorePerGame: Double?
    let distanceTraveled: Double?
    let deaths: Double?
    let objectiveBrC130BoxOpen: Double?
    let objectivePlunderCashBloodMoney: Double?
    let objectiveMunitionsBoxTeammateUsed: Double?
    let objectiveBrDownEnemyCircle4: Double?
    let objectiveBrDownEnemyCircle3: Double?
    let objectiveBrDownEnemyCircle2: Double?
    let objectiveBrDownEnemyCircle1: Double?
    let objectiveBrMissionPickupTablet: Double?
    let objectiveReviver: Double?
    let objectiveBrKioskBuy: Double?
    let kdRatio: Double?
    let gulagDeaths: Double?
    let timePlayed: Double?
    let headshotPercentage: Double?
    let matchesPlayed: Double?
    let executions: Double?
    let gulagKills: Double?
    let objectiveBrCacheOpen: Double?
    let damageDone: Double?
    let damageTaken: Double?
    
    private enum CodingKeys: String, CodingKey {
        case kills, objectiveTeamWiped, avgLifeTime, score, headshots, scorePerGame
        case assists, killsPerGame, scorePerMinute, distanceTraveled, deaths
        case objectiveBrC130BoxOpen, objectivePlunderCashBloodMoney, objectiveMunitionsBoxTeammateUsed, objectiveBrDownEnemyCircle4, objectiveBrDownEnemyCircle3
        case objectiveBrDownEnemyCircle2, objectiveBrDownEnemyCircle1, objectiveBrMissionPickupTablet, objectiveReviver, objectiveBrKioskBuy
        case kdRatio, gulagDeaths, timePlayed, headshotPercentage, matchesPlayed, executions, gulagKills, objectiveBrCacheOpen, damageDone, damageTaken
    }
}
