//
//  LeaderBoardDataStore.swift
//  Domain
//
//  Created by Gilwan Ryu on 2020/04/09.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import RxSwift

public protocol LeaderBoardDataStore {
    func getLeaderBoard(platform: Platform, filter: SearchFilter) -> Observable<LeaderBoardViewable>
}
