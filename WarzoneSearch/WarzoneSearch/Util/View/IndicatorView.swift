//
//  Indicator.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/02/04.
//  Copyright © 2020 Gilwan Ryu. All rights reserved.
//

import UIKit
import Lottie
import SnapKit

class IndicatorView {
    
    private var animationView = AnimationView()
    
    enum IndicatorType {
        case launch, loading, leaderBoard
    }
    
    init(type: IndicatorType) {
        self.type = type
    }
    
    private let type: IndicatorType
    private var superView: UIView = UIView()
    
    func play(view: UIView) {
        switch type {
        case .launch:
            animationView = AnimationView(name: "loading")
        case .loading:
            animationView = AnimationView(name: "loading")
        case .leaderBoard:
            animationView = AnimationView(name: "loadingTrophy")
        }
        
        animationView.contentMode = .scaleAspectFill
        animationView.tag = 999
        
        view.addSubview(animationView)
        view.bringSubviewToFront(animationView)
        
        animationView.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
            switch type {
            case .launch:
                $0.height.equalTo(100)
                $0.width.equalTo(100)
            case .loading:
                $0.height.equalTo(100)
                $0.width.equalTo(100)
            case .leaderBoard:
                $0.height.equalTo(100)
                $0.width.equalTo(100)
            }
        }
        animationView.loopMode = .loop
        superView = view
        
        DispatchQueue.main.async {
            self.animationView.play()
        }
    }
    
    func stop() {
        DispatchQueue.main.async {
            self.animationView.stop()
            self.remove()
        }
    }
    
    private func remove() {
        for subview in superView.subviews {
            if subview.tag == 999 {
                subview.removeFromSuperview()
            }
        }
    }
}
