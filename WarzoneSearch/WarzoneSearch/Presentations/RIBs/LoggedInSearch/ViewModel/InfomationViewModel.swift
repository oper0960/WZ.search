//
//  InfomationViewModel.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/18.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class InfomationViewModel: InfomationViewable {
    
    private var infomation: Infomation?
    
    init(infomation: Infomation) {
        self.infomation = infomation
    }
    
    init() {
        
    }
    
    var platform: UIImage {
        guard let info = infomation, let platform = info.platform else { return UIImage() }
        
        switch Platform(platform: platform) {
        case .psn:
            return #imageLiteral(resourceName: "Psn")
        case .battle:
            return #imageLiteral(resourceName: "BattleNet")
        case .steam:
            return #imageLiteral(resourceName: "Steam")
        case .none:
            return UIImage()
        }
    }
    
    var userName: String? {
        return infomation?.userName
    }
    
    var level: String {
        return Int(infomation?.level ?? 0).description
    }
    
    var levelXpRemainder: String {
        return (infomation?.levelXpRemainder ?? 0).groupingSeparator
    }
    
    var levelXpGained: String {
        return (infomation?.levelXpGained ?? 0).groupingSeparator
    }
    
    var totalXp: String {
        return (infomation?.totalXp ?? 0).groupingSeparator
    }
    
    var lifetimeAllBattleRoyal: LifetimeViewable? {
        guard let properties = infomation?.lifetime?.mode.brAll?.properties else { return nil }
        return LifetimeViewModel(properties: properties)
    }
    
    var lifetimeBattleRoyal: LifetimeViewable? {
        guard let properties = infomation?.lifetime?.mode.br?.properties else { return nil }
        return LifetimeViewModel(properties: properties)
    }
    
    var lifetimePlunder: LifetimeViewable? {
        guard let properties = infomation?.lifetime?.mode.brDmz?.properties else { return nil }
        return LifetimeViewModel(properties: properties)
    }
    
    var weeklyAllBattleRoyal: WeeklyViewable? {
        guard let properties = infomation?.weekly?.mode.brAll?.properties else { return nil }
        return WeeklyViewModel(properties: properties)
    }
    
    var weeklyBattleRoyal: WeeklyViewable? {
        guard let properties = infomation?.weekly?.mode.br87?.properties ?? infomation?.weekly?.mode.br25?.properties else { return nil }
        return WeeklyViewModel(properties: properties)
    }
    
    var weeklyPlunder: WeeklyViewable? {
        guard let properties = infomation?.weekly?.mode.brDmz?.properties else { return nil }
        return WeeklyViewModel(properties: properties)
    }
}

class LifetimeViewModel: LifetimeViewable {
    
    private var properties: ModeProperties?
    
    init(properties: ModeProperties) {
        self.properties = properties
    }
    
    var wins: String {
        return Int(properties?.wins ?? 0).description
    }
    
    var kills: String {
        return Int(properties?.kills ?? 0).description
    }
    
    var kdRatio: String {
        guard let kd = properties?.kdRatio else { return "0.00"}
        let numberOfPlaces = 2.0
        let multiplier = pow(10.0, numberOfPlaces)
        let rounded = round(kd * multiplier) / multiplier
        return rounded.description
    }
    
    var downs: String {
        return Int(properties?.downs ?? 0).description
    }
    
    var topTwentyFive: String {
        return Int(properties?.topTwentyFive ?? 0).description
    }
    
    var topTen: String {
        return Int(properties?.topTen ?? 0).description
    }
    
    var topFive: String {
        return Int(properties?.topFive ?? 0).description
    }
    
    var contracts: String {
        return Int(properties?.contracts ?? 0).description
    }
    
    var revives: String {
        return Int(properties?.revives ?? 0).description
    }
    
    var scorePerMinute: String {
        return Int(properties?.scorePerMinute ?? 0).description
    }
    
    var timePlayed: String {
        return Int((properties?.timePlayed ?? 0)/60).description
    }
    
    var score: String {
        return (properties?.score ?? 0.0).groupingSeparator
    }
    
    var gamesPlayed: String {
        return Int(properties?.gamesPlayed ?? 0).description
    }
    
    var cash: String  {
        return "dollar".localized + Int(properties?.cash ?? 0).description
    }
    
    var deaths: String {
        return Int(properties?.deaths ?? 0).description
    }
}

class WeeklyViewModel: WeeklyViewable {
    
    private var properties: WeeklyProperties?
    
    init(properties: WeeklyProperties) {
        self.properties = properties
    }
    
    init() {
        
    }
    
    var kills: String {
        return Int(properties?.kills ?? 0).description
    }
    
    var killsPerGame: String {
        return Int(properties?.scorePerGame ?? 0).description
    }
    
    var headshots: String {
        return Int(properties?.headshots ?? 0).description
    }
    
    var kdRatio: String {
        guard let kd = properties?.kdRatio else { return "0.00"}
        let numberOfPlaces = 2.0
        let multiplier = pow(10.0, numberOfPlaces)
        let rounded = round(kd * multiplier) / multiplier
        return rounded.description
    }
    
    var avgLifeTime: String {
        return Int((properties?.avgLifeTime ?? 0)/60).description
    }
    
    var timePlayed: String {
        return Int((properties?.timePlayed ?? 0)/60).description
    }
    
    var score: String {
        return (properties?.score ?? 0.0).groupingSeparator
    }
    
    var matchesPlayed: String {
        return Int(properties?.matchesPlayed ?? 0).description
    }
    
    var scorePerGame: String {
        return Int(properties?.scorePerGame ?? 0).description
    }
    
    var scorePerMinute: String {
        return Int(properties?.scorePerMinute ?? 0).description
    }
    
    var distanceTraveled: String {
        return Int(properties?.distanceTraveled ?? 0).description
    }
    
    var deaths: String {
        return Int(properties?.deaths ?? 0).description
    }
    
    var damageDone: String {
        return (properties?.damageDone ?? 0.0).groupingSeparator
    }
    
    var damageTaken: String {
        return (properties?.damageTaken ?? 0.0).groupingSeparator
    }
}

