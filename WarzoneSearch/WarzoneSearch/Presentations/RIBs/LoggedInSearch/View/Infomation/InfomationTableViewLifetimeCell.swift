//
//  InfomationTableViewLifetimeCell.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/19.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import Domain

class InfomationTableViewLifetimeCell: UITableViewCell {

    enum LifeTimeType {
        case all, battle, plunder
    }
    
    @IBOutlet weak var lifeTimeCollectionView: UICollectionView!
    
    var infomation: InfomationViewable = InfomationViewModel() {
        didSet {
            lifeTimeCollectionView.reloadData()
        }
    }
    
    private lazy var menu: [LifeTimeType] = {
        var arr = [LifeTimeType]()
        
        if infomation.lifetimeAllBattleRoyal != nil {
            arr.append(.all)
        }
        
        if infomation.lifetimeBattleRoyal != nil {
            arr.append(.battle)
        }
        
        if infomation.lifetimePlunder != nil {
            arr.append(.plunder)
        }
        
        return arr
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lifeTimeCollectionView.register(UINib(nibName: "InfomationCollectionViewLifeTimeCell", bundle: nil), forCellWithReuseIdentifier: "LifeTimeCell")
        lifeTimeCollectionView.delegate = self
        lifeTimeCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - CollectionView Delegate, Datesource, FlowLayout
extension InfomationTableViewLifetimeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        return CGSize(width: (contentView.frame.width - 80), height: lifeTimeCollectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LifeTimeCell", for: indexPath) as! InfomationCollectionViewLifeTimeCell
        
        switch menu[indexPath.section] {
        case .all:
            if let all = infomation.lifetimeAllBattleRoyal {
                cell.bind(title: "all".localized, lifetime: all)
            }
        case .battle:
            if let battle = infomation.lifetimeBattleRoyal {
                cell.bind(title: "battle".localized, lifetime: battle)
            }
        case .plunder:
            if let plunder = infomation.lifetimePlunder {
                cell.bind(title: "plunder".localized, lifetime: plunder)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    private func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<Any>) {
        let layout = self.lifeTimeCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
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
