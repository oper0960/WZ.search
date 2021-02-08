//
//  RootViewController.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class {
    // TODO: Business Logic의 수행을 위해 Interactor로 호출할 메소드, 프로퍼티를 구현
}

final class RootViewController: UIViewController {

    weak var listener: RootPresentableListener?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var blurImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup
extension RootViewController {
    func setup() {
        
    }
}

extension RootViewController: RootPresentable {
    
}

extension RootViewController: RootViewControllable {
    func present(modelPresentation: UIModalPresentationStyle, viewController: ViewControllable, complete: @escaping (() -> (Void))) {
        let presentingView = viewController.uiviewController
        presentingView.modalPresentationStyle = modelPresentation
        present(presentingView, animated: true, completion: complete)
    }
    
    func dismiss(viewController: ViewControllable) {
        if presentedViewController === viewController.uiviewController {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func editWebsite() {
        
        let codUrl = "https://cod.tracker.gg/modern-warfare/articles/how-to-public-stats"
        
        guard let url = URL(string: codUrl), UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
