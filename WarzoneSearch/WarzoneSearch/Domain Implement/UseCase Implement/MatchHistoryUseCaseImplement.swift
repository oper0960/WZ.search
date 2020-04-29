//
//  MatchHistoryUseCaseImplement.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/01.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import RxSwift

class MatchHistoryUseCaseImplement: MatchHistoryUseCase {

    private let matchHistoryRepository: MatchHistoryRepository

    init (matchHistoryRepository: MatchHistoryRepository) {
        self.matchHistoryRepository = matchHistoryRepository
    }
    
    func getUserMatchHistory(platform: Platform, id: String) -> Observable<MatchHistoryViewable> {
        return matchHistoryRepository.getUserMatchHistory(platform: platform, id: id)
    }
    
    func getUserMatchHistoryDetail(matchId: String) -> Observable<MatchHistoryDetailViewable> {
        return matchHistoryRepository.getUserMatchHistoryDetail(matchId: matchId)
    }
}
