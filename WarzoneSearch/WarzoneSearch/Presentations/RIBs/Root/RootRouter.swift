//
//  RootRouter.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, LoggedInSearchListener, LoggedOutSearchListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: View를 Control 하기 위해 ViewController에 전달할 메소드, 프로퍼티 구현
    func present(modelPresentation: UIModalPresentationStyle, viewController: ViewControllable, complete: @escaping () -> ())
    func dismiss(viewController: ViewControllable)
    func editWebsite()
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {

    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutSearchBuildable,
         loggedInBuilder: LoggedInSearchBuildable) {
        
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
     
    private let loggedOutBuilder: LoggedOutSearchBuildable
    private let loggedInBuilder: LoggedInSearchBuildable
    
    private var currentRouter: ViewableRouting?
}

extension RootRouter: RootRouting {
    func routeLoggedIn() {
        
        if let current = currentRouter {
            detachChild(current)
            viewController.dismiss(viewController: current.viewControllable)
        }
        
        let loggedIn = loggedInBuilder.build(withListener: interactor)
        currentRouter = loggedIn
        viewController.present(modelPresentation: .fullScreen, viewController: loggedIn.viewControllable, complete: {
            self.attachChild(loggedIn)
        })
    }
    
    func routeLoggedOut() {
        
        if let current = currentRouter {
            detachChild(current)
            viewController.dismiss(viewController: current.viewControllable)
        }
        
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        currentRouter = loggedOut
        viewController.present(modelPresentation: .fullScreen, viewController: loggedOut.viewControllable, complete: {
            self.attachChild(loggedOut)
        })
    }
    
    func editWebsite() {
        
        viewController.editWebsite()
        
        if let current = currentRouter {
            detachChild(current)
            viewController.dismiss(viewController: current.viewControllable)
        }
        
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        currentRouter = loggedOut
        viewController.present(modelPresentation: .fullScreen, viewController: loggedOut.viewControllable, complete: {
            self.attachChild(loggedOut)
        })
    }
}
