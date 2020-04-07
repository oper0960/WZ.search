//
//  SettingRouter.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/07.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs

protocol SettingInteractable: Interactable {
    var router: SettingRouting? { get set }
    var listener: SettingListener? { get set }
}

protocol SettingViewControllable: ViewControllable {
    // TODO: View를 Control 하기 위해 ViewController에 전달할 메소드, 프로퍼티 구현
}

final class SettingRouter: ViewableRouter<SettingInteractable, SettingViewControllable> {

    override init(interactor: SettingInteractable, viewController: SettingViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension SettingRouter: SettingRouting {
    
}
