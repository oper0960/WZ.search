//
//  NewInfomationViewModel.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/14.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class InfomationViewModel: InfomationViewable {
    
    private var infomation: InfomationData?
    
    init(infomation: InfomationData?) {
        self.infomation = infomation
    }
    
    init() {
        
    }
    
    var platform: UIImage {
        guard let info = infomation, let platform = info.platformInfo?.platformSlug else { return UIImage() }
        
        switch Platform(platform: platform) {
        case .psn:
            return #imageLiteral(resourceName: "Psn")
        case .battle:
            return #imageLiteral(resourceName: "BattleNet")
        case .xbl:
            return #imageLiteral(resourceName: "Xbox")
        case .none:
            return UIImage()
        }
    }
    
    var userId: String {
        return infomation?.platformInfo?.platformUserIdentifier ?? ""
    }
    
    var avatarUrl: URL? {
        
        guard let urlString = infomation?.platformInfo?.avatarUrl else { return nil }
        
        return URL(string: urlString)
    }
    
    var segments: [SegmentViewable] {
        guard let segments = infomation?.segments, segments.count > 0 else { return [] }
        
        var array = [SegmentViewable]()
        for segment in segments {
            array.append(SegmentViewModel(segment: segment))
        }
        return array
    }
}

class SegmentViewModel: SegmentViewable {
    
    private var segment: NewSegment?
    
    init(segment: NewSegment) {
        self.segment = segment
    }
    
    init() {
        
    }
    
    var type: String {
        return segment?.type ?? ""
    }
    
    var modeName: String {
        return segment?.metadata?.name ?? ""
    }
    
    var wins: String {
        return segment?.stats?.wins?.displayValue ?? "0"
    }
    
    var kills: String {
        return segment?.stats?.kills?.displayValue ?? "0"
    }
    
    var kdRatio: String {
        return segment?.stats?.kdRatio?.displayValue ?? "0"
    }
    
    var downs: String {
        return segment?.stats?.downs?.displayValue ?? "0"
    }
    
    var topTwentyFive: String {
        return segment?.stats?.top25?.displayValue ?? "0"
    }
    
    var topTen: String {
        return segment?.stats?.top10?.displayValue ?? "0"
    }
    
    var topFive: String {
        return segment?.stats?.top5?.displayValue ?? "0"
    }
    
    var contracts: String {
        return segment?.stats?.contracts?.displayValue ?? "0"
    }
    
    var revives: String {
        return segment?.stats?.revives?.displayValue ?? "0"
    }
    
    var scorePerMinute: String {
        return segment?.stats?.scorePerMinute?.displayValue ?? "0"
    }
    
    var timePlayed: String {
        return segment?.stats?.timePlayed?.displayValue ?? "0"
    }
    
    var score: String {
        return segment?.stats?.score?.displayValue ?? "0"
    }
    
    var gamesPlayed: String {
        return segment?.stats?.gamesPlayed?.displayValue ?? "0"
    }
    
    var cash: String {
        return segment?.stats?.cash?.displayValue ?? "0"
    }
    
    var deaths: String {
        return segment?.stats?.deaths?.displayValue ?? "0"
    }
    
    var level: String {
        return segment?.stats?.level?.displayValue ?? "0"
    }
    
    var levelXpProgression: String {
        return segment?.stats?.levelProgression?.displayValue ?? "0"
    }
    
    var levelXpTotal: String {
        return segment?.stats?.levelXpTotal?.displayValue ?? "0"
    }
}


