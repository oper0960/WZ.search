//
//  LeaderBoardVIewModel.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/09.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class LeaderBoardViewModel: LeaderBoardViewable {
    
    private var leaderBoardData: LeaderBoardData?
    
    init(data: LeaderBoardData) {
        self.leaderBoardData = data
    }
    
    init() {
        
    }
    
    var rankingType: String {
        return leaderBoardData?.metadata?.name ?? ""
    }
    
    var players: [PlayerViewable] {
        
        guard let items = leaderBoardData?.items else { return [] }
        
        var array = [PlayerViewModel]()
        
        for item in items {
            array.append(PlayerViewModel(item: item))
        }
        
        return array
    }
}
