//
//  LoggedInSearchRouter.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import Domain

protocol LoggedInSearchInteractable: Interactable, MatchHistoryDetailListener {
    var router: LoggedInSearchRouting? { get set }
    var listener: LoggedInSearchListener? { get set }
}

protocol LoggedInSearchViewControllable: ViewControllable {
    // TODO: View를 Control 하기 위해 ViewController에 전달할 메소드, 프로퍼티 구현
    func present(modelPresentation: UIModalPresentationStyle, viewController: UIViewController, complete: @escaping () -> ())
}

final class LoggedInSearchRouter: ViewableRouter<LoggedInSearchInteractable, LoggedInSearchViewControllable> {

    init(interactor: LoggedInSearchInteractable, viewController: LoggedInSearchViewControllable, historyDetailBuilder: MatchHistoryDetailBuildable) {
        
        self.matchHistoryDetailBuilder = historyDetailBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    private var matchHistoryDetailBuilder: MatchHistoryDetailBuildable
    private var currentRouter: ViewableRouting?
}

extension LoggedInSearchRouter: LoggedInSearchRouting {
    func routeHistoryDetail(detailData: MatchHistoryDetailViewable) {
        
        if let current = currentRouter {
            detachChild(current)
        }
        
        let detail = matchHistoryDetailBuilder.build(withListener: interactor, detailData: detailData)
        currentRouter = detail
        
        viewController.present(modelPresentation: .automatic, viewController: detail.viewControllable.uiviewController, complete: {
            self.attachChild(detail)
        })
    }
}
