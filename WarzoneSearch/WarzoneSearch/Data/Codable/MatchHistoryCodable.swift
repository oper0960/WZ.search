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
    let playerCount: Int?
    let teamCount: Int?
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
    let rank: Int?
    let percentile: Int?
    let displayName: String?
    let displayCategory: String?
    let category: String?
    let metadata: StatMetadata?
    let value: Double?
    let displayValue: String?
    let displayType: String?
    
    enum CodingKeys: String, CodingKey {
        case value = "value"
        case rank, percentile, displayName, displayCategory
        case category, metadata, displayValue, displayType
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = (try? values.decode(Double.self, forKey: .value)) ?? 0.0
        rank = try? values.decode(Int.self, forKey: .rank)
        percentile = try? values.decode(Int.self, forKey: .percentile)
        displayName = try? values.decode(String.self, forKey: .displayName)
        displayCategory = try? values.decode(String.self, forKey: .displayCategory)
        category = try? values.decode(String.self, forKey: .category)
        metadata = try? values.decode(StatMetadata.self, forKey: .metadata)
        displayValue = try? values.decode(String.self, forKey: .displayValue)
        displayType = try? values.decode(String.self, forKey: .displayType)
    }
}

// MARK: - StatMetadata
struct StatMetadata: Codable {
    
}



