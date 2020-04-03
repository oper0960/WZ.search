//
//  RootBuilder.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import Domain

protocol RootDependency: Dependency {
    
}

final class RootComponent: Component<RootDependency> {
    fileprivate var userUseCase: UserUseCase = {
        return UserUseCaseImplement(userRepository: UserRepositoryImplement(dataStore: UserDataStoreImplement()))
    }()
}

extension RootComponent: LoggedInSearchDependency, LoggedOutSearchDependency {
    var userStream: UserStream {
        return shared { UserStreamImpl() }
    }
}

// MARK: - Builder
protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController, userUseCase: component.userUseCase, userStream: component.userStream)
        
        let loggedOutBuilder = LoggedOutSearchBuilder(dependency: component)
        let loggedInBuilder = LoggedInSearchBuilder(dependency: component)
        
        return RootRouter(interactor: interactor, viewController: viewController, loggedOutBuilder: loggedOutBuilder, loggedInBuilder: loggedInBuilder)
    }
}
