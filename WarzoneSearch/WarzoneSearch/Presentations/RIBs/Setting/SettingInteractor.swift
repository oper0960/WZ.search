//
//  SettingInteractor.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/07.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import RxSwift

protocol SettingRouting: ViewableRouting {
    // TODO: 해당 RIB Router 를 통해 Sub-tree 를 관리하기 위해 구현
}

protocol SettingPresentable: Presentable {
    var listener: SettingPresentableListener? { get set }
    // TODO: Presenter 를 통해 ViewController로 전달할 메소드, 프로퍼티를 구현.
}

protocol SettingListener: class {
    // TODO: 부모 RIB 과의 통신을 위해 부모 RIB Interactor로 전달할 메소드, 프로퍼티 구현.
}

final class SettingInteractor: PresentableInteractor<SettingPresentable> {

    weak var router: SettingRouting?
    weak var listener: SettingListener?

    override init(presenter: SettingPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
}

extension SettingInteractor: SettingInteractable {
    
}

extension SettingInteractor: SettingPresentableListener {
    
}
