//
//  LoggedOutSearchBuilder.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import Domain

protocol LoggedOutSearchDependency: Dependency {
    var userStream: UserStream { get }
}

final class LoggedOutSearchComponent: Component<LoggedOutSearchDependency> {
    var userStream: UserStream {
        return dependency.userStream
    }
    
    fileprivate var userUseCase: UserUseCase = {
        return UserUseCaseImplement(userRepository: UserRepositoryImplement(dataStore: UserDataStoreImplement()))
    }()
}

// MARK: - Builder
protocol LoggedOutSearchBuildable: Buildable {
    func build(withListener listener: LoggedOutSearchListener) -> LoggedOutSearchRouting
}

final class LoggedOutSearchBuilder: Builder<LoggedOutSearchDependency>, LoggedOutSearchBuildable {

    override init(dependency: LoggedOutSearchDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedOutSearchListener) -> LoggedOutSearchRouting {
        let component = LoggedOutSearchComponent(dependency: dependency)
        let viewController = LoggedOutSearchViewController()
        let interactor = LoggedOutSearchInteractor(presenter: viewController, userStream: component.userStream, userUseCase: component.userUseCase)
        interactor.listener = listener
        return LoggedOutSearchRouter(interactor: interactor, viewController: viewController)
    }
}
