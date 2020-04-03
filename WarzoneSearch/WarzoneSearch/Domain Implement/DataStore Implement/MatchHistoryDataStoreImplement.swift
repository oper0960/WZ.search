//
//  MatchHistoryDataStoreImplement.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/01.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxAlamofire
import Alamofire
import SwiftyJSON

class MatchHistoryDataStoreImplement: MatchHistoryDataStore {

    // 매치 히스토리
    func getUserMatchHistory(platform: Platform, id: String) -> Observable<MatchHistoryViewable> {
        
        let urlString = Constants.MatchHistory.matchHistory
        
        let replacingPlatform = urlString.replacingOccurrences(of: "platform", with: platform.matchHistoryName)
        let replacingid = replacingPlatform.replacingOccurrences(of: "id", with: id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        
        print(replacingid)
        
        return RxAlamofire.requestData(.get, URL(string: replacingid)!,
                                       parameters: [:],
                                       encoding: URLEncoding(destination: .methodDependent),
                                       headers: [:])
            .map { _ , data in
                
                
                print(JSON(data))
                
                let decodableJson = try JSONDecoder().decode(MatchHistoryCodable.self, from: data)
                return MatchHistoryViewModel(matchHistoryData: decodableJson.data!)
        }
    }
}
