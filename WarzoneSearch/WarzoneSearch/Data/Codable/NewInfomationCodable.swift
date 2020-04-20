//
//  InfomationCodable.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/14.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
// MARK: - InfomationCodable
struct InfomationCodable: Codable {
    let data: InfomationData?
}

// MARK: - DataClass
struct InfomationData: Codable {
    let platformInfo: PlatformInfo?
    let userInfo: UserInfo?
    let segments: [NewSegment]?
    let expiryDate: String?
}

// MARK: - PlatformInfo
struct PlatformInfo: Codable {
    let platformSlug: String?
    let platformUserId: String?
    let platformUserHandle: String
    let platformUserIdentifier: String?
    let avatarUrl: String?
    let additionalParameters: String?
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let isPremium: Bool?
    let isVerified: Bool?
    let isInfluencer: Bool?
    let countryCode: String?
    let customAvatarUrl: String?
    let customHeroUrl: String?
}

// MARK: - Segment
struct NewSegment: Codable {
    let type: String?
    let attributes: Attributes?
    let metadata: NewSegmentMetadata?
    let expiryDate: String?
    let stats: Stats?
}

// MARK: - Attributes
struct Attributes: Codable {
    let mode: String?
}

// MARK: - SegmentMetadata
struct NewSegmentMetadata: Codable {
    let name: String?
}

// MARK: - Stats
struct Stats: Codable {
    let kills, deaths, downs, revives: StatsDetail?
    let kdRatio, wins, top5, top10: StatsDetail?
    let top25, gamesPlayed, timePlayed, wlRatio: StatsDetail?
    let score, scorePerMinute, scorePerGame, cash: StatsDetail?
    let contracts, averageLife: StatsDetail?
    let level: StatsDetail?
    let levelXpTotal, levelProgression: StatsDetail?
}

// MARK: - AverageLife
struct StatsDetail: Codable {
    let rank: Int?
    let percentile: Double?
    let displayName: String?
    let displayCategory: String?
    let category: String?
    let metadata: LevelMetadata?
    let value: Double?
    let displayValue: String?
    let displayType: String?
}

// MARK: - LevelMetadata
struct LevelMetadata: Codable {
    let iconUrl: String?
}



