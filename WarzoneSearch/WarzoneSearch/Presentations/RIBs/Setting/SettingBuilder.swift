//
//  SettingBuilder.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/07.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs

protocol SettingDependency: Dependency {
    // TODO: 부모 RIB에서 해당 RIB으로 전달 받아야할 데이터를 구현
}

final class SettingComponent: Component<SettingDependency> {
    // TODO: 해당 RIB에서만 사용되는 Dependency를 fileprivate 으로 선언
}

// MARK: - Builder
protocol SettingBuildable: Buildable {
    func build(withListener listener: SettingListener) -> SettingRouting
}

final class SettingBuilder: Builder<SettingDependency>, SettingBuildable {

    override init(dependency: SettingDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SettingListener) -> SettingRouting {
        let _ = SettingComponent(dependency: dependency)
        let viewController = SettingViewController()
        let interactor = SettingInteractor(presenter: viewController)
        interactor.listener = listener
        return SettingRouter(interactor: interactor, viewController: viewController)
    }
}
