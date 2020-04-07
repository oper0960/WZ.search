//
//  LeaderboardRouter.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/07.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs

protocol LeaderboardInteractable: Interactable {
    var router: LeaderboardRouting? { get set }
    var listener: LeaderboardListener? { get set }
}

protocol LeaderboardViewControllable: ViewControllable {
    // TODO: View를 Control 하기 위해 ViewController에 전달할 메소드, 프로퍼티 구현
}

final class LeaderboardRouter: ViewableRouter<LeaderboardInteractable, LeaderboardViewControllable> {

    override init(interactor: LeaderboardInteractable, viewController: LeaderboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension LeaderboardRouter: LeaderboardRouting {
    
}
