//
//  AboutInteractor.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/01/30.
//  Copyright © 2020 Gilwan Ryu. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa

protocol AboutRouting: ViewableRouting {
    func pushMenu(menu: SettingMenu)
}

protocol AboutPresentable: Presentable {
    var listener: AboutPresentableListener? { get set }
    
    func onSelected() -> PublishRelay<SettingMenu>
}

protocol AboutListener: class {
    func detechAbout()
}

final class AboutInteractor: PresentableInteractor<AboutPresentable> {

    weak var router: AboutRouting?
    weak var listener: AboutListener?

    override init(presenter: AboutPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        setRx()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

extension AboutInteractor {
    func setRx() {
        presenter.onSelected().subscribe(onNext: { [weak self] menu in
            guard let self = self else { return }
            self.router?.pushMenu(menu: menu)
        }).disposeOnDeactivate(interactor: self)
    }
}

// MARK: - AboutInteractable
extension AboutInteractor: AboutInteractable {
    
}

extension AboutInteractor: AboutPresentableListener {
    func detechAbout() {
        listener?.detechAbout()
    }
}
