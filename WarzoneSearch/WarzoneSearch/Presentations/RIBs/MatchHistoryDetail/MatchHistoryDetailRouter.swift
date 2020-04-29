//
//  MatchHistoryDetailRouter.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/27.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs

protocol MatchHistoryDetailInteractable: Interactable {
    var router: MatchHistoryDetailRouting? { get set }
    var listener: MatchHistoryDetailListener? { get set }
}

protocol MatchHistoryDetailViewControllable: ViewControllable {
    // TODO: View를 Control 하기 위해 ViewController에 전달할 메소드, 프로퍼티 구현
}

final class MatchHistoryDetailRouter: ViewableRouter<MatchHistoryDetailInteractable, MatchHistoryDetailViewControllable> {

    override init(interactor: MatchHistoryDetailInteractable, viewController: MatchHistoryDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension MatchHistoryDetailRouter: MatchHistoryDetailRouting {
    
}
