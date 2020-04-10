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
    func getLeaderBoard(platform: Platform, filter: SearchFilter)
}

final class LeaderboardViewController: UIViewController {
    
    private var platforms: [Platform] = {
        var array = [Platform]()
        array.append(.none)
        array.append(.psn)
        array.append(.xbl)
        array.append(.battle)
        return array
    }()
    
    private var filters: [SearchFilter] = {
        var array: [SearchFilter] = [.kills, .deaths, .downs, .revives,
                                     .kdRatio, .timePlayed, .score, .scorePerMinute,
                                     .cash, .contracts, .wins, .top5, .top10, .top25,
                                     .totalMatches, .winPercent, .scorePerGame, .averageLife,
                                     .level, .totalXp]
        return array
    }()
    
    weak var listener: LeaderboardPresentableListener?
    
    @IBOutlet var platformButtons: [UIButton]!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var leaderBoardTableView: UITableView!
    
    private var selectedPlatform: Platform = .none
    private var selectedFilter: SearchFilter = .kills
    private var selectedFilterIndex: Int = 0
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
                    self.selectedPlatform = .none
                case .psn:
                    self.selectedPlatform = .psn
                case .xbl:
                    self.selectedPlatform = .xbl
                case .battle:
                    self.selectedPlatform = .battle
                }
            }
            self.listener?.getLeaderBoard(platform: self.selectedPlatform, filter: self.selectedFilter)
        }).disposed(by: disposeBag)
        
        
        filterCollectionView.register(UINib(nibName: "LeaderBoardFilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LeaderBoardCell")
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        
        listener?.getLeaderBoard(platform: selectedPlatform, filter: selectedFilter)
    }
}

// MARK: - CollectionView Delegate, Datesource, FlowLayout
extension LeaderboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.text = filters[indexPath.row].displayName
        label.sizeToFit()
        
        return CGSize(width: label.bounds.width + 30, height: filterCollectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaderBoardCell", for: indexPath) as! LeaderBoardFilterCollectionViewCell
        cell.bind(title: filters[indexPath.row].displayName)
        
        if selectedFilterIndex == indexPath.row {
            cell.setSelected()
        } else {
            cell.setDeSelected()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFilter = filters[indexPath.row]
        selectedFilterIndex = indexPath.row
        
        filterCollectionView.reloadData()
        listener?.getLeaderBoard(platform: selectedPlatform, filter: selectedFilter)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
//extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return users.count > 3 ? 3 : users.count
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//       return 40
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let historyCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! SearchHistoryTableViewCell
//        let user = users[indexPath.row]
//        historyCell.bind(user: user)
//        return historyCell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let user = users[indexPath.row]
//        listener?.searchUser(user: user)
//    }
//}

extension LeaderboardViewController: LeaderboardPresentable {
    
}

extension LeaderboardViewController: LeaderboardViewControllable {
    
}
