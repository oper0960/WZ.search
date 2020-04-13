//
//  LoggedOutSearchInteractor.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import Domain

protocol LoggedOutSearchRouting: ViewableRouting {
    // TODO: 해당 RIB Router 를 통해 Sub-tree 를 관리하기 위해 구현
    func routeAbout()
    func routeLeaderBoard()
    func detechRouter()
}

protocol LoggedOutSearchPresentable: Presentable {
    var listener: LoggedOutSearchPresentableListener? { get set }
    // TODO: Presenter 를 통해 ViewController로 전달할 메소드, 프로퍼티를 구현.
    
    // From VC
    var onClickSearchButton: Observable<(Platform,String)> { get }
    var onClickAboutButton: ControlEvent<()> { get }
    var onClickLeaderBoardButton: ControlEvent<()> { get }
    
    // To VC
    func setSearchHistory(users: [UserViewable])
}

protocol LoggedOutSearchListener: class {
    // TODO: 부모 RIB 과의 통신을 위해 부모 RIB Interactor로 전달할 메소드, 프로퍼티 구현.
    func completeLoggedIn()
}

final class LoggedOutSearchInteractor: PresentableInteractor<LoggedOutSearchPresentable> {

    weak var router: LoggedOutSearchRouting?
    weak var listener: LoggedOutSearchListener?
    
    private var disposeBag = DisposeBag()

    init(presenter: LoggedOutSearchPresentable, userStream: UserStream, userUseCase: UserUseCase) {
        
        self.userStream = userStream
        self.userUseCase = userUseCase
        
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        setRx()
        getSearchHistory()
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    private var userStream: UserStream
    private var userUseCase: UserUseCase
}

extension LoggedOutSearchInteractor {
    func setRx() {
        presenter
            .onClickSearchButton
            .subscribe(onNext: { [weak self] user in
                guard let self = self else { return }
                self.userStream.updateUser(platform: user.0, id: user.1)
                self.listener?.completeLoggedIn()
            }).disposed(by: disposeBag)
        
        presenter
            .onClickLeaderBoardButton
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.router?.routeLeaderBoard()
            }).disposed(by: disposeBag)
        
        presenter
            .onClickAboutButton
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.router?.routeAbout()
            }).disposed(by: disposeBag)
    }
    
    func getSearchHistory() {
        userUseCase.getUserList().subscribe(onNext: { [weak self] users in
            guard let self = self else { return }
            self.presenter.setSearchHistory(users: users)
            }, onError: { error in
                print(error)
        }).disposed(by: disposeBag)
    }
}

extension LoggedOutSearchInteractor: LoggedOutSearchInteractable {
    func detachLeaderBoard() {
        router?.detechRouter()
    }
    
    func detechAbout() {
        router?.detechRouter()
    }
    
    func searchLeaderBoardPlayer(platform: Platform, id: String) {
        userStream.updateUser(platform: platform, id: id)
        listener?.completeLoggedIn()
    }
}

extension LoggedOutSearchInteractor: LoggedOutSearchPresentableListener {
    func searchUser(user: UserViewable) {
        guard let platform = user.platform, let id = user.id else { return }
        userStream.updateUser(platform: Platform(platform: platform), id: id)
        listener?.completeLoggedIn()
    }
}
