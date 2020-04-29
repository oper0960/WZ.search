//
//  MatchHistoryDetailBuilder.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/27.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import Domain

protocol MatchHistoryDetailDependency: Dependency {
    // TODO: 부모 RIB에서 해당 RIB으로 전달 받아야할 데이터를 구현
}

final class MatchHistoryDetailComponent: Component<MatchHistoryDetailDependency> {
    // TODO: 해당 RIB에서만 사용되는 Dependency를 fileprivate 으로 선언
    
    
}

// MARK: - Builder
protocol MatchHistoryDetailBuildable: Buildable {
    func build(withListener listener: MatchHistoryDetailListener, detailData: MatchHistoryDetailViewable) -> MatchHistoryDetailRouting
}

final class MatchHistoryDetailBuilder: Builder<MatchHistoryDetailDependency>, MatchHistoryDetailBuildable {

    override init(dependency: MatchHistoryDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MatchHistoryDetailListener, detailData: MatchHistoryDetailViewable) -> MatchHistoryDetailRouting {
        let _ = MatchHistoryDetailComponent(dependency: dependency)
        let viewController = MatchHistoryDetailViewController()
        let interactor = MatchHistoryDetailInteractor(presenter: viewController, detailData: detailData)
        interactor.listener = listener
        return MatchHistoryDetailRouter(interactor: interactor, viewController: viewController)
    }
}
