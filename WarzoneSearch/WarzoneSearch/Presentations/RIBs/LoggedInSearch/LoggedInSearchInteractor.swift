//
//  LoggedInSearchInteractor.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import Domain

protocol LoggedInSearchRouting: ViewableRouting {
    // TODO: 해당 RIB Router 를 통해 Sub-tree 를 관리하기 위해 구현
}

protocol LoggedInSearchPresentable: Presentable {
    var listener: LoggedInSearchPresentableListener? { get set }
    // TODO: Presenter 를 통해 ViewController로 전달할 메소드, 프로퍼티를 구현.
    
    var onClickCloseButton: ControlEvent<()> { get }
    
//    func setInfomation(infomation: InfomationViewable, matchs: MatchHistoryViewable?)
    func setNewInfomation(infomation: NewInfomationViewable, matchs: MatchHistoryViewable?)
    func playLoading()
    func stopLoading()
    func showNotAccountAlert()
}

protocol LoggedInSearchListener: class {
    // TODO: 부모 RIB 과의 통신을 위해 부모 RIB Interactor로 전달할 메소드, 프로퍼티 구현.
    func closeInfomationView()
}

final class LoggedInSearchInteractor: PresentableInteractor<LoggedInSearchPresentable> {

    weak var router: LoggedInSearchRouting?
    weak var listener: LoggedInSearchListener?
    
    init(presenter: LoggedInSearchPresentable, userStream: UserStream, matchHistoryUseCase: MatchHistoryUseCase, infomationUseCase: InfomationUseCase, userUseCase: UserUseCase) {
        
        self.matchHistoryUseCase = matchHistoryUseCase
        self.infomationUseCase = infomationUseCase
        self.userUseCase = userUseCase
        self.userStream = userStream
        
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        setRx()
        getUserInfomation()
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    private let matchHistoryUseCase: MatchHistoryUseCase
    private let infomationUseCase: InfomationUseCase
    private let userUseCase: UserUseCase
    private let userStream: UserStream
    private var disposeBag = DisposeBag()
}

extension LoggedInSearchInteractor {
    
    func setRx() {
        presenter
            .onClickCloseButton
            .subscribe(onNext: { [weak self]_ in
                guard let self = self else { return }
                self.listener?.closeInfomationView()
            }).disposed(by: disposeBag)
    }
    
    func getUserInfomation() {
        
        let id = userStream.id.asObservable()
        let platform = userStream.platform.asObservable()
        
        presenter.playLoading()
        Observable.combineLatest(id, platform).subscribe { [weak self] user in
            guard let self = self else { return }
            guard let element = user.element else { return }
            
            self.infomationUseCase.getUserNewInfomation(platform: element.1, id: element.0).subscribe(onNext: { [weak self] infomation in
                guard let self = self else { return }

                print("1")
                guard !infomation.userId.isEmpty else {
                    print("2")
                    self.presenter.showNotAccountAlert()
                    return
                }
                print("3")

                self.userUseCase.saveUser(platform: element.1, id: element.0)
                print("4                       ")
                self.matchHistoryUseCase.getUserMatchHistory(platform: element.1, id: element.0).subscribe(onNext: { [weak self] match in
                    guard let self = self else { return }
                    self.presenter.setNewInfomation(infomation: infomation, matchs: match)
                    }, onError: { error in
                        self.presenter.setNewInfomation(infomation: infomation, matchs: nil)
                }, onDisposed: {
                    self.presenter.stopLoading()
                }).disposed(by: self.disposeBag)
            }).disposed(by: self.disposeBag)
            
//            self.infomationUseCase.getUserInfomation(platform: element.1, id: element.0).subscribe(onNext: { [weak self] infomation in
//                guard let self = self else { return }
//
//                guard infomation.userName != nil else {
//                    self.presenter.showNotAccountAlert()
//                    return
//                }
//                self.userUseCase.saveUser(platform: element.1, id: element.0)
//
//                self.matchHistoryUseCase.getUserMatchHistory(platform: element.1, id: element.0).subscribe(onNext: { [weak self] match in
//                    guard let self = self else { return }
//                    self.presenter.setInfomation(infomation: infomation, matchs: match)
//                    }, onError: { error in
//                        self.presenter.setInfomation(infomation: infomation, matchs: nil)
//                }, onDisposed: {
//                    self.presenter.stopLoading()
//                }).disposed(by: self.disposeBag)
//            }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }
}

extension LoggedInSearchInteractor: LoggedInSearchInteractable {
    
}

extension LoggedInSearchInteractor: LoggedInSearchPresentableListener {
    func routeLoggedOut() {
        listener?.closeInfomationView()
    }
}
