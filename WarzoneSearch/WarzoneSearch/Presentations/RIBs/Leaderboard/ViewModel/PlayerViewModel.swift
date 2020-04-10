//
//  PlayerViewModel.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/09.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class PlayerViewModel: PlayerViewable {
    private var leaderBoardItem: Item?
    
    init(item: Item) {
        self.leaderBoardItem = item
    }
    
    init() {
        
    }
}
