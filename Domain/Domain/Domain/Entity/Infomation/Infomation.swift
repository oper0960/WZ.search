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
    var platform: UIImage { get }                               // 플랫폼 (PSN, Xbox, BattleNet)
    var userName: String? { get }                               // 유저 닉네임
    var level: String { get }                                   // 현재 레벨
    var levelXpRemainder: String { get }                        // 다음 레벨업에 필요한 경험치
    var levelXpGained: String { get }                           // 현재 레벨에서 얻은 경험치
    var totalXp: String { get }                                 // 총 경험치
    
    var lifetimeAllBattleRoyal: LifetimeViewable? { get }       // 총 게임 플레이 중 약탈, 배틀로얄 합계
    var lifetimeBattleRoyal: LifetimeViewable? { get }          // 총 게임 플레이 중 배틀로얄
    var lifetimePlunder: LifetimeViewable? { get }              // 총 게임 플레이 중 약탈
    
    var weeklyAllBattleRoyal: WeeklyViewable? { get }           // 주간 게임 플레이 중 약탈, 배틀로얄 합계
    var weeklyBattleRoyal: WeeklyViewable? { get }              // 주간 게임 플레이 중 WeeklyViewable
    var weeklyPlunder: WeeklyViewable? { get }                  // 주간 게임 플레이 중 약탈
}

public protocol LifetimeViewable {
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
}

public protocol WeeklyViewable {
    var kills: String { get }                                   // 총 처치 수
    var kdRatio: String { get }                                 // KD Ratio
    var scorePerGame: String { get }                            // 1 게임당 평균 획득 점수
    var avgLifeTime: String { get }                             // 평균 생존 시간
    var timePlayed: String { get }                              // 총 플레이 타임
    var score: String { get }                                   // 총 획득 점수
    var matchesPlayed: String { get }                           // 플레이 횟수
    var headshots: String { get }                               // 헤드샷 횟수
    var killsPerGame: String { get }                            // 1 게임당 평균 킬 수
    var scorePerMinute: String { get }                          // 1 분당 획득 점수
    var damageDone: String { get }                              // 가한 데미지
    var distanceTraveled: String { get }                        // 이동거리
    var deaths: String { get }                                  // 총 사망 수
    var damageTaken: String { get }                             // 입은 데미지
}


