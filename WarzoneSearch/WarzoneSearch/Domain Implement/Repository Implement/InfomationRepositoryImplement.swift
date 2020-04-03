//
//  InfomationRepositoryImplement.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import RxSwift

class InfomationRepositoryImplement: InfomationRepository {
    
    private let dataStore: InfomationDataStore
    
    init(dataStore: InfomationDataStore) {
        self.dataStore = dataStore
    }
    
    func getUserInfomation(platform: Platform, id: String) -> Observable<InfomationViewable> {
        return dataStore.getUserInfomation(platform: platform, id: id)
    }
}
