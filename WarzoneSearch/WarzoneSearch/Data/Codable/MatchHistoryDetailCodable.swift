//
//  MatchHistoryDetailCodable.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/27.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

// MARK: - MatchHistoryDetailCodable
struct MatchHistoryDetailCodable: Codable {
    let data: MatchHistoryDetailData?
}

// MARK: - DataClass
struct MatchHistoryDetailData: Codable {
    let attributes: MatchAttributes?
    let metadata: MatchDetailMetadata?
    let segments: [DetailSegment]?
}

// MARK: - Segment
struct DetailSegment: Codable {
    let type: String?
    let attributes: DetailAttributes?
    let metadata: DetailMetadata?
    let expiryDate: String?
    let stats: [String: Stat]?
}

// MARK: - MatchDetailMetadata
struct MatchDetailMetadata: Codable {
    let duration: Duration?
    let timestamp: Int?
    let playerCount: Int?
    let teamCount: Int?
    let mapName: String?
    let mapImageUrl: String?
    let modeName: String?
}

// MARK: - DetailAttributes
struct DetailAttributes: Codable {
    let platformUserIdentifier: String?
    let platformSlug: String?
    let team: String?
}

// MARK: - DetailMetadata
struct DetailMetadata: Codable {
    let platformUserHandle: String?
    let clanTag: String?
    let placement: DetailPlacement?
    let plunder: DetailPlunder?
}

// MARK: - DetailMetadata
struct DetailPlacement: Codable {
    let value: Int?
    let displayValue: String?
    let displayType: String?
}

// MARK: - DetailPlunder
struct DetailPlunder: Codable {
    let value: Int?
    let displayValue: String?
    let displayType: String?
}
