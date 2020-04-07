//
//  LoggedOutSearchRouter.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs

protocol LoggedOutSearchInteractable: Interactable, AboutListener {
    var router: LoggedOutSearchRouting? { get set }
    var listener: LoggedOutSearchListener? { get set }
}

protocol LoggedOutSearchViewControllable: ViewControllable {
    // TODO: View를 Control 하기 위해 ViewController에 전달할 메소드, 프로퍼티 구현
    func present(modelPresentation: UIModalPresentationStyle, viewController: UIViewController, complete: @escaping () -> ())
}

final class LoggedOutSearchRouter: ViewableRouter<LoggedOutSearchInteractable, LoggedOutSearchViewControllable> {

    init(interactor: LoggedOutSearchInteractable,
         viewController: LoggedOutSearchViewControllable,
         aboutBuilder: AboutBuildable,
         navigation: UINavigationController) {
        
        self.aboutBuilder = aboutBuilder
        self.navigation = navigation
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    private var aboutBuilder: AboutBuildable
    private var currentRouter: ViewableRouting?
    private var navigation: UINavigationController
}

extension LoggedOutSearchRouter {
    
}

extension LoggedOutSearchRouter: LoggedOutSearchRouting {
    func detechAbout() {
        navigation.setViewControllers([], animated: false)
        
        if let current = currentRouter {
            self.detachChild(current)
        }
    }
    
    func routeAbout() {
        if let current = currentRouter {
            detachChild(current)
        }
        
        let about = aboutBuilder.build(withListener: interactor)
        currentRouter = about
        
        navigation.setViewControllers([about.viewControllable.uiviewController], animated: true)
        
        viewController.present(modelPresentation: .automatic, viewController: self.navigation, complete: {
            self.attachChild(about)
        })
    }
}
