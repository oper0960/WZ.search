//
//  BaseViewController.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/25.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var keyboardHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.removeNotification()
        self.addNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeNotification()
    }
    
    // MARK: Observers
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(_:)), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterForeground(_:)), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    func removeNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func keyboardWillChange(_ notification: Notification, keyboardSize: CGRect){}
    func willResignActive() {}//백그라운드1
    func didEnterBackground() {}//백그라운드2
    func willEnterForeground() {}//포그라운드1
    func didBecomeActive() {}//포그라운드2
}

//keyboard, copy 관련 메서드
extension BaseViewController{
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize1 = ((notification as NSNotification).userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        guard let keyboardSize2 = ((notification as NSNotification).userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        self.keyboardHeight = keyboardSize1.height == 0 ? keyboardSize2.height : keyboardSize1.height
        self.keyboardWillChange(notification, keyboardSize: keyboardSize1.height == 0 ? keyboardSize2 : keyboardSize1)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        self.keyboardWillChange(notification, keyboardSize: CGRect.zero)
    }
    @objc private func applicationWillResignActive(_ sender: AnyObject) {
        self.willResignActive()
    }
    @objc private func applicationDidEnterBackground(_ sender: AnyObject) {
        self.didEnterBackground()
    }
    @objc private func applicationWillEnterForeground(_ sender: AnyObject) {
        self.willEnterForeground()
    }
    @objc private func applicationDidBecomeActive(_ sender: AnyObject) {
        self.didBecomeActive()
    }
}
