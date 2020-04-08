//
//  LeaderboardViewController.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/07.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import Domain

protocol LeaderboardPresentableListener: class {
    // TODO: Business Logic의 수행을 위해 Interactor로 호출할 메소드, 프로퍼티를 구현
}

final class LeaderboardViewController: UIViewController {
    
    weak var listener: LeaderboardPresentableListener?
    
    @IBOutlet var platformButtons: [UIButton]!
    
    
    private var platforms: [Platform] = {
        var array = [Platform]()
        array.append(.none)
        array.append(.psn)
        array.append(.xbl)
        array.append(.battle)
        return array
    }()
    
    private var platform: Platform = .none
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup
extension LeaderboardViewController {
    func setup() {
        let tags = platformButtons
            .map { ($0.rx.tap, $0.tag) }
            .map { obs, tag in obs.map { tag } }
        let mergeButtons = Observable.merge(tags)
        
        mergeButtons.subscribe(onNext: { index in
            for button in self.platformButtons {
                button.isSelected = button.tag == index
                
                switch self.platforms[index] {
                case .none:
                    self.platform = .none
                case .psn:
                    self.platform = .psn
                case .xbl:
                    self.platform = .xbl
                case .battle:
                    self.platform = .battle
                }
            }
            
            print(self.platformButtons[index].tag)
        }).disposed(by: disposeBag)
    }
}

extension LeaderboardViewController: LeaderboardPresentable {
    
}

extension LeaderboardViewController: LeaderboardViewControllable {
    
}
