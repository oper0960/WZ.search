//
//  UserUseCaseImplement.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import RxSwift

class UserUseCaseImplement: UserUseCase  {
    
    private let userRepository: UserRepository

    init (userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func getUserList() -> Observable<[UserViewable]> {
        return userRepository.getUserList()
    }
    
    func saveUser(platform: Platform, id: String) {
        userRepository.saveUser(platform: platform, id: id)
    }
}
