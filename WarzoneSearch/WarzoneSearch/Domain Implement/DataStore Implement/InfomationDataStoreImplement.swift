//
//  InfomationDataStoreImplement.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import Alamofire
import RxAlamofire
import SwiftyJSON

class InfomationDataStoreImplement: InfomationDataStore {
    
    // 기본 유저 정보
    func getUserInfomation(platform: Platform, id: String) -> Observable<InfomationViewable> {
        
        let urlString = Constants.Infomation.infomation
        
        let replacingPlatform = urlString.replacingOccurrences(of: "where", with: platform.name)
        let replacingid = replacingPlatform.replacingOccurrences(of: "id", with: id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        
        return RxAlamofire.requestData(.get, URL(string: replacingid)!,
                                       parameters: [:],
                                       encoding: URLEncoding(destination: .methodDependent),
                                       headers: [:])
            .map { _ , data in
                
                
//                print(JSON(data))
                
                let decodableJson = try JSONDecoder().decode(InfomationCodable.self, from: data)
                return InfomationViewModel(infomation: decodableJson.infomation)
        }
    }
}
