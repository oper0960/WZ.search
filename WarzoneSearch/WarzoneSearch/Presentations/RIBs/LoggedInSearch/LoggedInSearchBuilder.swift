//
//  LoggedInSearchBuilder.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import Domain

protocol LoggedInSearchDependency: Dependency {
    var userStream: UserStream { get }
}

final class LoggedInSearchComponent: Component<LoggedInSearchDependency> {
    var userStream: UserStream {
        return dependency.userStream
    }
    
    fileprivate var matchHistoryUseCase: MatchHistoryUseCase = {
        return MatchHistoryUseCaseImplement(matchHistoryRepository: MatchHistoryRepositoryImplement(dataStore: MatchHistoryDataStoreImplement()))
    }()
    
    fileprivate var infomationUseCase: InfomationUseCase = {
        return InfomationUseCaseImplement(infomationRepository: InfomationRepositoryImplement(dataStore: InfomationDataStoreImplement()))
    }()
    
    fileprivate var userUseCase: UserUseCase = {
        return UserUseCaseImplement(userRepository: UserRepositoryImplement(dataStore: UserDataStoreImplement()))
    }()
}

// MARK: - Builder
protocol LoggedInSearchBuildable: Buildable {
    func build(withListener listener: LoggedInSearchListener) -> LoggedInSearchRouting
}

final class LoggedInSearchBuilder: Builder<LoggedInSearchDependency>, LoggedInSearchBuildable {

    override init(dependency: LoggedInSearchDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInSearchListener) -> LoggedInSearchRouting {
        let component = LoggedInSearchComponent(dependency: dependency)
        let viewController = LoggedInSearchViewController()
        let interactor = LoggedInSearchInteractor(presenter: viewController, userStream: component.userStream, matchHistoryUseCase: component.matchHistoryUseCase, infomationUseCase: component.infomationUseCase, userUseCase: component.userUseCase)
        interactor.listener = listener
        return LoggedInSearchRouter(interactor: interactor, viewController: viewController)
    }
}
