//
//  LeaderBoardCodable.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/09.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

// MARK: - LeaderBoardCodable
struct LeaderBoardCodable: Codable {
    let data: LeaderBoardData?
}

// MARK: - DataClass
struct LeaderBoardData: Codable {
    let id: String?
    let metadata: LeaderBoardMetadata?
    let items: [Item]?
    let expiryDate: String?
}

// MARK: - DataMetadata
struct LeaderBoardMetadata: Codable {
    let name, title: String?
}

// MARK: - Item
struct Item: Codable {
    let id: String?
    let owner: Owner?
    let value: Double?
    let displayValue: String?
    let rank: Int?
    let percentile: Int?
}

// MARK: - Owner
struct Owner: Codable {
    let id: String?
    let type: String?
    let metadata: OwnerMetadata?
    let stats: [LeaderBoardStat]?
}

// MARK: - OwnerMetadata
struct OwnerMetadata: Codable {
    let platformId: Int?
    let platformSlug: String?
    let platformUserHandle, platformUserIdentifier: String?
    let countryCode: String?
    let pictureUrl, avatarUrl: String?
    let isPremium: Bool?
    let twitter, twitch: String?
}

// MARK: - Stat
struct LeaderBoardStat: Codable {
    let metadata: LeaderBoardStatMetadata?
    let percentile: Int?
    let rank: Int?
    let displayPercentile: String?
    let displayRank: String?
    let value: Int?
    let displayValue: String?
}

// MARK: - StatMetadata
struct LeaderBoardStatMetadata: Codable {
    let key: String?
    let name: String?
    let metadataDescription: String?
    let categoryKey: String?
    let categoryName: String?
    let isReversed: Bool?
    let iconUrl: String?
    let color: String?
    let value: Int?
    let displayValue: String?

    enum CodingKeys: String, CodingKey {
        case key, name
        case metadataDescription = "description"
        case categoryKey, categoryName, isReversed, iconUrl, color, value, displayValue
    }
}

