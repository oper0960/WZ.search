//
//  InfomationUseCaseImplement.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain
import RxSwift

class InfomationUseCaseImplement: InfomationUseCase {
    
    private let infomationRepository: InfomationRepository

    init (infomationRepository: InfomationRepository) {
        self.infomationRepository = infomationRepository
    }
    
    func getUserInfomation(platform: Platform, id: String) -> Observable<InfomationViewable> {
        return infomationRepository.getUserInfomation(platform: platform, id: id)
    }
}
