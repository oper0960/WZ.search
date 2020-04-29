//
//  MatchHistoryDataStore.swift
//  Domain
//
//  Created by Gilwan Ryu on 2020/04/01.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import RxSwift

public protocol MatchHistoryDataStore {
    func getUserMatchHistory(platform: Platform, id: String) -> Observable<MatchHistoryViewable>
    func getUserMatchHistoryDetail(matchId: String) -> Observable<MatchHistoryDetailViewable>
}
