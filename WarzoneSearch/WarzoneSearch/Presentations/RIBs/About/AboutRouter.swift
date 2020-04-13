//
//  AboutRouter.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/01/30.
//  Copyright © 2020 Gilwan Ryu. All rights reserved.
//

import RIBs

protocol AboutInteractable: Interactable, OpenSourceListener, SettingListener {
    var router: AboutRouting? { get set }
    var listener: AboutListener? { get set }
}

protocol AboutViewControllable: ViewControllable {
    func push(viewController: ViewControllable, completion: @escaping (() -> ()))
    func presentFeedback()
}

final class AboutRouter: ViewableRouter<AboutInteractable, AboutViewControllable> {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: AboutInteractable,
         viewController: AboutViewControllable,
         openSourceBuilder: OpenSourceBuildable,
         settingBuilder: SettingBuildable) {
        
        self.openSourceBuilder = openSourceBuilder
        self.settingBuilder = settingBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    private let openSourceBuilder: OpenSourceBuildable
    private let settingBuilder: SettingBuildable
    private var currentRouter: ViewableRouting?
}

extension AboutRouter: AboutRouting {
    func pushMenu(menu: SettingMenu) {
        
        if !children.isEmpty {
            for child in children {
                detachChild(child)
            }
        }
        switch menu {
        case .option:
            let setting = settingBuilder.build(withListener: interactor)
            currentRouter = setting
            viewController.push(viewController: setting.viewControllable) {
                self.attachChild(setting)
            }
        case .opensource:
            let openSource = openSourceBuilder.build(withListener: interactor)
            currentRouter = openSource
            viewController.push(viewController: openSource.viewControllable) {
                self.attachChild(openSource)
            }
        case .version, .admob:
            break
        case .feedback:
            viewController.presentFeedback()
            
        }
    }
}
