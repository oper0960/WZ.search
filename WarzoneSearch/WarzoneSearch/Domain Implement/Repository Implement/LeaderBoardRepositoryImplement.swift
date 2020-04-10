//
//  LeaderBoardRepositoryImplement.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/09.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import RxSwift

class LeaderBoardRepositoryImplement: LeaderBoardRepository {
    
    private let dataStore: LeaderBoardDataStore
    
    init(dataStore: LeaderBoardDataStore) {
        self.dataStore = dataStore
    }
    
    func getLeaderBoard(platform: Platform, filter: SearchFilter) -> Observable<LeaderBoardViewable> {
        return dataStore.getLeaderBoard(platform: platform, filter: filter)
    }
}
