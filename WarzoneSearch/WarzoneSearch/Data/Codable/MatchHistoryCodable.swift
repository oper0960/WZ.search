//
//  MatchHistoryCodable.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/31.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//


import Foundation

// MARK: - MatchHistoryCodable
struct MatchHistoryCodable: Codable {
    let data: MatchHistoryData?
}

// MARK: - DataClass
struct MatchHistoryData: Codable {
    let matches: [Match]?
    let metadata: DataMetadata?
    let paginationType: Int?
    let requestingPlayerAttributes: RequestingPlayerAttributes?
}

// MARK: - Match
struct Match: Codable {
    let attributes: MatchAttributes?
    let metadata: MatchMetadata?
    let segments: [Segment]?
}

// MARK: - DataMetadata
struct DataMetadata: Codable {
    let next: Int?
}

// MARK: - RequestingPlayerAttributes
struct RequestingPlayerAttributes: Codable {
    let platformUserIdentifier: String?
}

// MARK: - MatchAttributes
struct MatchAttributes: Codable {
    let id: String?
    let mapId: String?
    let modeId: String?
}

// MARK: - MatchMetadata
struct MatchMetadata: Codable {
    let duration: Duration?
    let timestamp: String?
    let playerCount, teamCount: Int?
    let mapName: String?
    let mapImageUrl: String?
    let modeName: String?
}

// MARK: - Duration
struct Duration: Codable {
    let value: Int?
    let displayValue: String?
    let displayType: String?
}

// MARK: - Segment
struct Segment: Codable {
    let type: String?
    let attributes: SegmentAttributes?
    let metadata: SegmentMetadata?
    let expiryDate: String?
    let stats: [String: Stat]?
}

// MARK: - SegmentAttributes
struct SegmentAttributes: Codable {
    let platformUserIdentifier: String?
    let platformSlug: String?
    let team: String?
}

// MARK: - SegmentMetadata
struct SegmentMetadata: Codable {
    let platformUserHandle: String?
    let clanTag: String?
    let placement: Int?
}

// MARK: - Stat
struct Stat: Codable {
    let rank, percentile: Int?
    let displayName: String?
    let displayCategory: String?
    let category: String?
    let metadata: StatMetadata?
    let value: Double?
    let displayValue: String?
    let displayType: String?
}

// MARK: - StatMetadata
struct StatMetadata: Codable {
    
}



