//
//  RootInteractor.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import RxSwift
import Domain

protocol RootRouting: ViewableRouting {
    func routeLoggedIn()
    func routeLoggedOut()
    func editWebsite()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Presenter 를 통해 ViewController로 전달할 메소드, 프로퍼티를 구현.
}

protocol RootListener: class {
    // TODO: 부모 RIB 과의 통신을 위해 부모 RIB Interactor로 전달할 메소드, 프로퍼티 구현.
}

final class RootInteractor: PresentableInteractor<RootPresentable> {

    weak var router: RootRouting?
    weak var listener: RootListener?

    init(presenter: RootPresentable, userUseCase: UserUseCase, userStream: UserStream) {
        
        self.userUseCase = userUseCase
        self.userStream = userStream
        
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        if userDefault.bool(forKey: UserSettings.latestAccountAutoSearch) {
            getLastLoggedInId()
        } else {
            router?.routeLoggedOut()
        }
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    private let userUseCase: UserUseCase
    private let userStream: UserStream
    private var disposeBag = DisposeBag()
}

extension RootInteractor {
    
    func getLastLoggedInId() {
        userUseCase.getUserList().subscribe(onNext: { [weak self] users in
            
            guard let self = self else { return }
            
            guard let user = users.first, let platform = user.platform, let id = user.id else  {
                self.router?.routeLoggedOut()
                return
            }
            
            self.userStream.updateUser(platform: Platform(platform: platform), id: id)
            self.router?.routeLoggedIn()
            
            }, onError: { error in
                print(error)
        }).disposed(by: disposeBag)
    }
}

extension RootInteractor: RootInteractable {
    func completeLoggedIn() {
        router?.routeLoggedIn()
    }
    
    func closeInfomationView() {
        router?.routeLoggedOut()
    }
    
    func editWebsite() {
        router?.editWebsite()
    }
}

extension RootInteractor: RootPresentableListener {
    
}
