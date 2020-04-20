//
//  InfomationUseCase.swift
//  Domain
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import RxSwift

public protocol InfomationUseCase {
    func getUserInfomation(platform: Platform, id: String) -> Observable<InfomationViewable>
}
