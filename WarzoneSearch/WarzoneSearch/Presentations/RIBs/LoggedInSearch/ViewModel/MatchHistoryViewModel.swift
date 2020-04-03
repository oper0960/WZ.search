//
//  MatchHistoryViewModel.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/01.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class MatchHistoryViewModel: MatchHistoryViewable {
    
    private var matchHistoryData: MatchHistoryData
    
    init(matchHistoryData: MatchHistoryData) {
        self.matchHistoryData = matchHistoryData
    }
    
    var matchs: [MatchViewable] {
        
        guard let matchs = matchHistoryData.matches else { return [] }
        
        var array = [MatchViewModel]()
        
        for match in matchs {
            array.append(MatchViewModel(match: match))
        }
        
        return array
    }
}

