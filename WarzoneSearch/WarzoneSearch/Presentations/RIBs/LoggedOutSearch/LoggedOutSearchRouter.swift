//
//  LoggedOutSearchRouter.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs

protocol LoggedOutSearchInteractable: Interactable {
    var router: LoggedOutSearchRouting? { get set }
    var listener: LoggedOutSearchListener? { get set }
}

protocol LoggedOutSearchViewControllable: ViewControllable {
    // TODO: View를 Control 하기 위해 ViewController에 전달할 메소드, 프로퍼티 구현
}

final class LoggedOutSearchRouter: ViewableRouter<LoggedOutSearchInteractable, LoggedOutSearchViewControllable> {

    override init(interactor: LoggedOutSearchInteractable, viewController: LoggedOutSearchViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension LoggedOutSearchRouter: LoggedOutSearchRouting {
    
}
