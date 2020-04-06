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
    
    private var disposeBag = DisposeBag()
    
    // 매치 히스토리
    func getUserMatchHistory(platform: Platform, id: String) -> Observable<MatchHistoryViewable> {
        
        let profileUrlString = Constants.MatchHistory.profile
        
        let replacingProfilePlatform = profileUrlString.replacingOccurrences(of: "platform", with: platform.matchHistoryName)
        let replacingProfileid = replacingProfilePlatform.replacingOccurrences(of: "id", with: id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        
        let profileObservable = RxAlamofire.requestData(.get, URL(string: replacingProfileid)!,
                                                        parameters: [:],
                                                        encoding: URLEncoding(destination: .methodDependent),
                                                        headers: [:])
            .map { _ , data in
                return JSON(data)
        }
        
        let urlString = Constants.MatchHistory.matchHistory
        
        let replacingPlatform = urlString.replacingOccurrences(of: "platform", with: platform.matchHistoryName)
        let replacingid = replacingPlatform.replacingOccurrences(of: "id", with: id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        
        let historyObservable = RxAlamofire.requestData(.get, URL(string: replacingid)!,
                                                        parameters: nil,
                                                        encoding: URLEncoding(destination: .methodDependent),
                                                        headers: nil)
            .map { data -> MatchHistoryViewable in
                let decodableJson = try JSONDecoder().decode(MatchHistoryCodable.self, from: data.1)
                
                guard let data = decodableJson.data else { return MatchHistoryViewModel() }
                
                return MatchHistoryViewModel(matchHistoryData: data)
        }
        
        return profileObservable
            .filter{ profile in profile["data"]["platformInfo"]["platformUserHandle"].string != nil}
            .concatMap({ profile in historyObservable })
    }
}
