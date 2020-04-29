//
//  LoggedOutSearchViewController.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import Domain
import FirebaseCrashlytics

protocol LoggedOutSearchPresentableListener: class {
    // TODO: Business Logic의 수행을 위해 Interactor로 호출할 메소드, 프로퍼티를 구현
    func searchUser(user: UserViewable)
}

final class LoggedOutSearchViewController: BaseViewController {
    
    weak var listener: LoggedOutSearchPresentableListener?
    
    @IBOutlet weak var leaderBoardButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var blurImageView: UIImageView!
    @IBOutlet weak var inputPopupView: UIViewCustom!
    @IBOutlet weak var psnButton: UIButtonCustom!
    @IBOutlet weak var xboxButton: UIButtonCustom!
    @IBOutlet weak var battleButton: UIButtonCustom!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var inputViewBottom: NSLayoutConstraint!
    @IBOutlet weak var searchHistoryTableView: UITableView!
    
    private var disposeBag = DisposeBag()
    private var platform: Platform = .none
    private var users = [UserViewable]() {
        didSet {
            searchHistoryTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func keyboardWillChange(_ notification: Notification, keyboardSize: CGRect) {
        var keyboardHeight = keyboardSize.height
        if #available(iOS 11.0, *) {
            if keyboardSize.height != 0{
                keyboardHeight = keyboardSize.height - self.view.safeAreaInsets.bottom
            }
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                if keyboardHeight > 0 {
                    self.inputViewBottom.constant = 50 + keyboardHeight
                    self.inputPopupView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8)
                } else {
                    self.inputViewBottom.constant = 150
                    self.inputPopupView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)
                }
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Setup
 extension LoggedOutSearchViewController {
    
    func setTableView() {
        searchHistoryTableView.register(UINib(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        searchHistoryTableView.delegate = self
        searchHistoryTableView.dataSource = self
    }
    
    func setup() {
        
        searchButton.setTitle("go".localized, for: .normal)
        blurImageView.image = UIImage().imageWithColor(forRect: blurImageView.bounds, tintColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6))
        idTextField.inputAccessoryView = setDoneKeyboard()
        idTextField.attributedPlaceholder = NSAttributedString(string: "",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        psnButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.platformLabel.text = "PSN"
                self.platform = .psn
                self.enableKeyboard(platform: self.platform)
            }).disposed(by: disposeBag)
        
        xboxButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.platformLabel.text = "XBOX"
                self.platform = .xbl
                self.enableKeyboard(platform: self.platform)
            }).disposed(by: disposeBag)
        
        battleButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.platformLabel.text = "BATTLENET"
                self.platform = .battle
                self.enableKeyboard(platform: self.platform)
            }).disposed(by: disposeBag)
    }
    
    func enableKeyboard(platform: Platform) {
        switch platform {
        case .psn:
            self.idTextField.placeholder = "enterpsn".localized
        case .battle:
            self.idTextField.placeholder = "enterbattlenet".localized
        case .xbl:
            self.idTextField.placeholder = "enterxbox".localized
        case .none:
            return
        }
        self.idTextField.isEnabled = true
        self.idTextField.becomeFirstResponder()
    }
    
    func setDoneKeyboard() -> UIToolbar {
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btnDoneBar = UIBarButtonItem(title: "done".localized, style: .done, target: self, action: #selector(self.doneBtnClicked))
        toolBarKeyboard.items = [flexibleSpace,btnDoneBar]
        toolBarKeyboard.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return toolBarKeyboard
    }
    
    @IBAction func doneBtnClicked (sender: Any) {
        self.view.endEditing(true)
    }
    
    func showNotSelectedPlatformAlert() {
        let alert = UIAlertController(title: "not_select_platform_title".localized, message: "not_select_platform_message".localized, preferredStyle: .alert)
        let done = UIAlertAction(title: "done".localized, style: .default, handler: nil)
        alert.addAction(done)
        present(alert, animated: true, completion: nil)
    }
    
    func showEmptyIDAlert() {
        let alert = UIAlertController(title: "empty_id_title".localized, message: "empty_id_message".localized, preferredStyle: .alert)
        let done = UIAlertAction(title: "done".localized, style: .default, handler: { _ in
            self.idTextField.becomeFirstResponder()
        })
        alert.addAction(done)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LoggedOutSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count > 3 ? 3 : users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let historyCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! SearchHistoryTableViewCell
        let user = users[indexPath.row]
        historyCell.bind(user: user)
        return historyCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        listener?.searchUser(user: user)
    }
}

extension LoggedOutSearchViewController: LoggedOutSearchPresentable {
   
    var onClickSearchButton: Observable<(Platform, String)> {
        return searchButton.rx.tap.filter { _ in
            
            guard self.platform != .none else {
                self.showNotSelectedPlatformAlert()
                return false
            }
            
            guard let id = self.idTextField.text, !id.isEmpty else {
                self.showEmptyIDAlert()
                return false
            }
            
            return !id.isEmpty
        }.map { [weak self] _ in
            guard let self = self else { return (.none, "") }
            return (self.platform, self.idTextField.text!)
        }
    }
    
    var onClickLeaderBoardButton: ControlEvent<()> {
        return leaderBoardButton.rx.controlEvent(.touchUpInside)
    }
    
    var onClickAboutButton: ControlEvent<()> {
        return aboutButton.rx.controlEvent(.touchUpInside)
    }
    
    func setSearchHistory(users: [UserViewable]) {
        self.users = users
    }
}

extension LoggedOutSearchViewController: LoggedOutSearchViewControllable {
    func present(modelPresentation: UIModalPresentationStyle, viewController: UIViewController, complete: @escaping (() -> (Void))) {
        let presentingView = viewController
        presentingView.modalPresentationStyle = modelPresentation
        present(presentingView, animated: true, completion: complete)
    }
}
