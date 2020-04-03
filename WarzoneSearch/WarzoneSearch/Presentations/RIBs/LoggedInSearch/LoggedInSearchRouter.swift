//
//  LoggedInSearchRouter.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs

protocol LoggedInSearchInteractable: Interactable {
    var router: LoggedInSearchRouting? { get set }
    var listener: LoggedInSearchListener? { get set }
}

protocol LoggedInSearchViewControllable: ViewControllable {
    // TODO: View를 Control 하기 위해 ViewController에 전달할 메소드, 프로퍼티 구현
}

final class LoggedInSearchRouter: ViewableRouter<LoggedInSearchInteractable, LoggedInSearchViewControllable> {

    override init(interactor: LoggedInSearchInteractable, viewController: LoggedInSearchViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension LoggedInSearchRouter: LoggedInSearchRouting {
    
}
