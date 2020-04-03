//
//  UserStream.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RxSwift
import RxCocoa
import Domain

protocol UserStream {
    var platform: BehaviorRelay<Platform> { get }
    var id: BehaviorRelay<String> { get }
    
    func updateUser(platform: Platform, id: String)
}

class UserStreamImpl: UserStream {
    
    var platform: BehaviorRelay<Platform> = BehaviorRelay(value: .none)
    var id: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    func updateUser(platform: Platform, id: String) {
        self.platform.accept(platform)
        self.id.accept(id)
    }
}
