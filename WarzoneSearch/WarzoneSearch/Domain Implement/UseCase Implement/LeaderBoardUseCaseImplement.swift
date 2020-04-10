//
//  LeaderBoardUseCaseImplement.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/09.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import RxSwift

class LeaderBoardUseCaseImplement: LeaderBoardUseCase {
    
    private let leaderBoardRepository: LeaderBoardRepository

    init (leaderBoardRepository: LeaderBoardRepository) {
        self.leaderBoardRepository = leaderBoardRepository
    }
    
    func getLeaderBoard(platform: Platform, filter: SearchFilter) -> Observable<LeaderBoardViewable> {
        return leaderBoardRepository.getLeaderBoard(platform: platform, filter: filter)
    }
}
