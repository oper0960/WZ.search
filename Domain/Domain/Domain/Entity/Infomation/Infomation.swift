//
//  Infomation.swift
//  Domain
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

// MARK: - Infomation ViewModel
public protocol InfomationViewable {
    var platform: UIImage { get }                               // 플랫폼 (XBOX, PSN, BATTLENET)
    var userId: String { get }                                  // ID
    var avatarUrl: URL? { get }                                 // Profile URL
    var segments: [SegmentViewable] { get }                     // Lifetime, BattleRoyal, Plunder
}

public protocol SegmentViewable {
    var type: String { get }
    var modeName: String { get }
    var wins: String { get }                                    // 총 승리 수
    var kills: String { get }                                   // 총 처치 수
    var kdRatio: String { get }                                 // KD Ratio
    var downs: String { get }                                   // 총 다운 수
    var topTwentyFive: String { get }                           // 총 Top 25 횟수
    var topTen: String { get }                                  // 총 Top 10 횟수
    var topFive: String { get }                                 // 총 Top 5 횟수
    var contracts: String { get }                               // 총 계약 성공 횟수
    var revives: String { get }                                 // 총 부활 수
    var scorePerMinute: String { get }                          // 1 분당 획득 점수
    var timePlayed: String { get }                              // 총 플레이 타임
    var score: String { get }                                   // 총 획득 점수
    var gamesPlayed: String { get }                             // 총 플레이 횟수
    var cash: String { get }                                    // 총 획득 금액
    var deaths: String { get }                                  // 총 사망 수
    var level: String { get }                                   // 현재 레벨
    var levelXpProgression: String { get }                      // 현재 경험치 퍼센테이지
    var levelXpTotal: String { get }                            // 총 경험치
}


