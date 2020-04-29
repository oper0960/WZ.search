//
//  MatchHistoryRepositoryImplement.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/01.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import RxSwift

class MatchHistoryRepositoryImplement: MatchHistoryRepository {

    private let dataStore: MatchHistoryDataStore
    
    init(dataStore: MatchHistoryDataStore) {
        self.dataStore = dataStore
    }
    
    func getUserMatchHistory(platform: Platform, id: String) -> Observable<MatchHistoryViewable> {
        return dataStore.getUserMatchHistory(platform: platform, id: id)
    }
    
    func getUserMatchHistoryDetail(matchId: String) -> Observable<MatchHistoryDetailViewable> {
        return dataStore.getUserMatchHistoryDetail(matchId: matchId)
    }
}
