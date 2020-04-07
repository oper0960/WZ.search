//
//  SettingTableViewCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/07.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var onoffButton: UISwitch!
    
    private var option: OptionMenu?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(menu: OptionMenu) {
        
        switch menu {
        case .autoSearch:
            option = menu
            titleLabel.text = "LatestAutoSearch".localized
            onoffButton.setOn(userDefault.bool(forKey: UserSettings.latestAccountAutoSearch), animated: true)
        }
    }
    
    @IBAction func onoffButton(_ sender: UISwitch) {
        
        guard let option = option else { return }
        
        switch option {
        case .autoSearch:
            userDefault.set(sender.isOn, forKey: UserSettings.latestAccountAutoSearch)
        }
    }
}
