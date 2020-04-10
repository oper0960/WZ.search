//
//  LeaderboardInteractor.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/07.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import RxSwift
import Domain

protocol LeaderboardRouting: ViewableRouting {
    // TODO: 해당 RIB Router 를 통해 Sub-tree 를 관리하기 위해 구현
}

protocol LeaderboardPresentable: Presentable {
    var listener: LeaderboardPresentableListener? { get set }
    // TODO: Presenter 를 통해 ViewController로 전달할 메소드, 프로퍼티를 구현.
}

protocol LeaderboardListener: class {
    // TODO: 부모 RIB 과의 통신을 위해 부모 RIB Interactor로 전달할 메소드, 프로퍼티 구현.
}

final class LeaderboardInteractor: PresentableInteractor<LeaderboardPresentable> {

    weak var router: LeaderboardRouting?
    weak var listener: LeaderboardListener?

    init(presenter: LeaderboardPresentable, leaderBoardUseCase: LeaderBoardUseCase) {
        
        self.leaderBoardUseCase = leaderBoardUseCase
        
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    private var leaderBoardUseCase: LeaderBoardUseCase
    private var disposeBag = DisposeBag()
}

extension LeaderboardInteractor: LeaderboardInteractable {
    
}

extension LeaderboardInteractor: LeaderboardPresentableListener {
    func getLeaderBoard(platform: Platform, filter: SearchFilter) {
        leaderBoardUseCase
            .getLeaderBoard(platform: platform, filter: filter)
            .subscribe(onNext: { list in
                
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
}
