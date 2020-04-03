//
//  UserRepositoryImplement.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import RxSwift

class UserRepositoryImplement: UserRepository {
    
    private let dataStore: UserDataStore
    
    init(dataStore: UserDataStore) {
        self.dataStore = dataStore
    }
    
    func getUserList() -> Observable<[UserViewable]> {
        return dataStore.getUserList()
    }
    
    func saveUser(platform: Platform, id: String) {
        self.dataStore.saveUser(platform: platform, id: id)
    }
}
