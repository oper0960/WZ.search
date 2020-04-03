//
//  InfomationTableViewWeeklyCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/19.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class InfomationTableViewWeeklyCell: UITableViewCell {
    
    enum WeeklyType {
        case all, battle, plunder
    }
    
    @IBOutlet weak var weeklyCollectionView: UICollectionView!
    
    var infomation: InfomationViewable = InfomationViewModel() {
        didSet {
            weeklyCollectionView.reloadData()
        }
    }
    
    private lazy var menu: [WeeklyType] = {
        var arr = [WeeklyType]()
        
        if infomation.weeklyAllBattleRoyal != nil {
            arr.append(.all)
        }
        
        if infomation.weeklyBattleRoyal != nil {
            arr.append(.battle)
        }
        
        if infomation.weeklyPlunder != nil {
            arr.append(.plunder)
        }
        
        return arr
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        weeklyCollectionView.register(UINib(nibName: "InfomationCollectionViewWeeklyCell", bundle: nil), forCellWithReuseIdentifier: "weeklyCell")
        weeklyCollectionView.delegate = self
        weeklyCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - CollectionView Delegate, Datesource, FlowLayout
extension InfomationTableViewWeeklyCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (contentView.frame.width - 80), height: weeklyCollectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weeklyCell", for: indexPath) as! InfomationCollectionViewWeeklyCell
        
        switch menu[indexPath.section] {
        case .all:
            if let all = infomation.weeklyAllBattleRoyal {
                cell.bind(title: "all".localized, weekly: all)
            }
        case .battle:
            if let battle = infomation.weeklyBattleRoyal {
                cell.bind(title: "battle".localized, weekly: battle)
            }
        case .plunder:
            if let plunder = infomation.weeklyPlunder {
                cell.bind(title: "plunder".localized, weekly: plunder)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    private func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<Any>) {
        let layout = self.weeklyCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = ((offset as AnyObject).x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        if scrollView.contentOffset.x > (targetContentOffset.pointee as AnyObject).x {
            roundedIndex = floor(index)
        } else {
            roundedIndex = ceil(index)
        }
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}


