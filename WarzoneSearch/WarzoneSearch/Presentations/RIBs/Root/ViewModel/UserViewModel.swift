//
//  UserViewModel.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class UserViewModel: UserViewable {
    
    private var user: User?
    
    init(user: User) {
        self.user = user
    }
    
    var id: String? {
        return user?.id
    }
    
    var platform: String? {
        return user?.platform
    }
    
    var updateTime: Date {
        return user?.updateTime ?? Date()
    }
}
