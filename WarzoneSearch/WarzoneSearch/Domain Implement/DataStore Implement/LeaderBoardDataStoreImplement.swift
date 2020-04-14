//
//  LeaderBoardDataStoreImplement.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/09.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxAlamofire
import Alamofire
import SwiftyJSON

class LeaderBoardDataStoreImplement: LeaderBoardDataStore {
    func getLeaderBoard(platform: Platform, filter: SearchFilter) -> Observable<LeaderBoardViewable> {
        
        let urlString = Constants.MatchHistory.leaderboard
        
        let replacingPlatform = urlString.replacingOccurrences(of: "where", with: platform.leaderBoardName)
        let replacingid = replacingPlatform.replacingOccurrences(of: "filter", with: filter.apiName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        
        return RxAlamofire.requestData(.get, URL(string: replacingid)!,
                                       parameters: [:],
                                       encoding: URLEncoding(destination: .methodDependent),
                                       headers: [:])
//            .timeout(10, scheduler: MainScheduler.instance)
            .map { _ , data in
//                print(JSON(data))
                
                let decodableJson = try JSONDecoder().decode(LeaderBoardCodable.self, from: data)
                
                guard let data = decodableJson.data else { return LeaderBoardViewModel() }
                
                return LeaderBoardViewModel(data: data)
        }
    }
}
