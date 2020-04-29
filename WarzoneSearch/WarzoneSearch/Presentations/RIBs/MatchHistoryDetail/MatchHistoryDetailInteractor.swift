//
//  MatchHistoryDetailInteractor.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/27.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import RxSwift
import Domain

protocol MatchHistoryDetailRouting: ViewableRouting {
    // TODO: 해당 RIB Router 를 통해 Sub-tree 를 관리하기 위해 구현
}

protocol MatchHistoryDetailPresentable: Presentable {
    var listener: MatchHistoryDetailPresentableListener? { get set }
    
    func setDetailData(data: MatchHistoryDetailViewable)
}

protocol MatchHistoryDetailListener: class {
    // TODO: 부모 RIB 과의 통신을 위해 부모 RIB Interactor로 전달할 메소드, 프로퍼티 구현.
}

final class MatchHistoryDetailInteractor: PresentableInteractor<MatchHistoryDetailPresentable> {

    weak var router: MatchHistoryDetailRouting?
    weak var listener: MatchHistoryDetailListener?

    init(presenter: MatchHistoryDetailPresentable, detailData: MatchHistoryDetailViewable) {
        
        self.detailData = detailData
        
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setDetailData(data: detailData)
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    private var detailData: MatchHistoryDetailViewable
}

extension MatchHistoryDetailInteractor: MatchHistoryDetailInteractable {
    
}

extension MatchHistoryDetailInteractor: MatchHistoryDetailPresentableListener {
    
}
