//
//  LeaderboardBuilder.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/07.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import Domain

protocol LeaderboardDependency: Dependency {
    var userStream: UserStream { get }
}

final class LeaderboardComponent: Component<LeaderboardDependency> {
    // TODO: 해당 RIB에서만 사용되는 Dependency를 fileprivate 으로 선언
    fileprivate var leaderBoardUseCase: LeaderBoardUseCase = {
        return LeaderBoardUseCaseImplement(leaderBoardRepository: LeaderBoardRepositoryImplement(dataStore: LeaderBoardDataStoreImplement()))
    }()
    
    var userStream: UserStream {
        return dependency.userStream
    }
}

// MARK: - Builder
protocol LeaderboardBuildable: Buildable {
    func build(withListener listener: LeaderboardListener) -> LeaderboardRouting
}

final class LeaderboardBuilder: Builder<LeaderboardDependency>, LeaderboardBuildable {

    override init(dependency: LeaderboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LeaderboardListener) -> LeaderboardRouting {
        let component = LeaderboardComponent(dependency: dependency)
        let viewController = LeaderboardViewController()
        let interactor = LeaderboardInteractor(presenter: viewController, leaderBoardUseCase: component.leaderBoardUseCase)
        interactor.listener = listener
        return LeaderboardRouter(interactor: interactor, viewController: viewController)
    }
}
