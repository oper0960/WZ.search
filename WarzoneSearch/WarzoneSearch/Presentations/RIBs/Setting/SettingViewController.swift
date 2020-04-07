//
//  SettingViewController.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/07.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

enum OptionMenu {
    case autoSearch
}

protocol SettingPresentableListener: class {
    // TODO: Business Logic의 수행을 위해 Interactor로 호출할 메소드, 프로퍼티를 구현
}

final class SettingViewController: UIViewController {

    weak var listener: SettingPresentableListener?
    
    @IBOutlet weak var settingTableView: UITableView!
    
    private var menuArray: [OptionMenu] = {
        var array = [OptionMenu]()
        array.append(.autoSearch)
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Setting".localized
        setTableView()
        setup()
    }
}

// MARK: - Setup
extension SettingViewController {
    
    private func setTableView() {
        settingTableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionCell")
        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    
    private func setup() {
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingCell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! SettingTableViewCell
        settingCell.bind(menu: menuArray[indexPath.row])
        return settingCell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension SettingViewController: SettingPresentable {
    
}

extension SettingViewController: SettingViewControllable {
    
}
