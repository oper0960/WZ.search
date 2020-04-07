//
//  LeaderboardViewController.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/07.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol LeaderboardPresentableListener: class {
    // TODO: Business Logic의 수행을 위해 Interactor로 호출할 메소드, 프로퍼티를 구현
}

final class LeaderboardViewController: UIViewController {

    weak var listener: LeaderboardPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup
extension LeaderboardViewController {
    func setup() {
        
    }
}

extension LeaderboardViewController: LeaderboardPresentable {
    
}

extension LeaderboardViewController: LeaderboardViewControllable {
    
}
