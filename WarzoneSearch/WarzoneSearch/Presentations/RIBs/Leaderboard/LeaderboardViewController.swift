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
import GoogleMobileAds

protocol LeaderboardPresentableListener: class {
    // TODO: Business Logic의 수행을 위해 Interactor로 호출할 메소드, 프로퍼티를 구현
    func getLeaderBoard(platform: Platform, filter: SearchFilter)
    func detachLeaderBoard()
    func routeLeaderBoardPlayer(platform: Platform, id: String)
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
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var admobViewHeight: NSLayoutConstraint!
    
    private let indicator = IndicatorView(type: .leaderBoard)
    private var selectedPlatform: Platform = .none
    private var selectedFilter: SearchFilter = .kills
    private var selectedFilterIndex: Int = 0
    private var disposeBag = DisposeBag()
    
    private var leaderBoardData: LeaderBoardViewable? {
        didSet {
            leaderBoardTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setAdMob()
    }
}

// MARK: - Setup
extension LeaderboardViewController: UIAdaptivePresentationControllerDelegate {
    
    private func setAdMob() {
        var bannerView: GADBannerView!

        let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)

        bannerView = GADBannerView(adSize: adaptiveSize)
        
        admobViewHeight.constant = adaptiveSize.size.height
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
        
        admobView.addSubview(bannerView)
        bannerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        #if DEBUG
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        #else
        bannerView.adUnitID = "ca-app-pub-9335296893721653/3508432499"
        #endif
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(GADRequest())
    }
    
    private func setup() {
        let tags = platformButtons
            .map { ($0.rx.tap, $0.tag) }
            .map { obs, tag in obs.map { tag } }
        let mergeButtons = Observable.merge(tags)
        
        mergeButtons.subscribe(onNext: { [weak self] index in
            guard let self = self else { return }
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
        
        presentationController?.delegate = self
        
        filterCollectionView.register(UINib(nibName: "LeaderBoardFilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LeaderBoardFilterCell")
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        
        leaderBoardTableView.register(UINib(nibName: "LeaderBoardTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaderBoardCell")
        leaderBoardTableView.delegate = self
        leaderBoardTableView.dataSource = self
        
        indicator.play(view: self.view)
        listener?.getLeaderBoard(platform: selectedPlatform, filter: selectedFilter)
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        listener?.detachLeaderBoard()
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
        label.text = filters[indexPath.row].displayName.localized
        label.sizeToFit()
        
        return CGSize(width: label.bounds.width + 30, height: filterCollectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaderBoardFilterCell", for: indexPath) as! LeaderBoardFilterCollectionViewCell
        cell.bind(title: filters[indexPath.row].displayName.localized)
        
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
extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderBoardData?.players.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 155
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rankCell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoardCell", for: indexPath) as! LeaderBoardTableViewCell
        guard let data = leaderBoardData else { return rankCell }
        rankCell.bind(player: data.players[indexPath.row], rankFilter: selectedFilter.displayName.localized)
        return rankCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let routeProfile = UIAlertAction(title: "routeProfile".localized, style: .default) { action in
            guard let data = self.leaderBoardData else { return }
            let player = data.players[indexPath.row]
            
            if Platform(platform: player.platformString) != .none {
                self.listener?.routeLeaderBoardPlayer(platform: Platform(platform: player.platformString), id: player.id)
            } else {
                let alert = UIAlertController(title: "atvi_coming_title".localized, message: "atvi_coming_message".localized, preferredStyle: .alert)
                let done = UIAlertAction(title: "done".localized, style: .default, handler: nil)
                alert.addAction(done)
                self.present(alert, animated: true, completion: nil)
            }
        }
        let cancel = UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil)
        alert.addAction(routeProfile)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

extension LeaderboardViewController: LeaderboardPresentable {
    func setLeaderBoard(leaderBoard: LeaderBoardViewable) {
        leaderBoardData = leaderBoard
    }
    
    func startIndicator() {
        indicator.play(view: self.view)
        view.isUserInteractionEnabled = false
    }
    
    func stopIndicator() {
        indicator.stop()
        view.isUserInteractionEnabled = true
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "error".localized, message: message, preferredStyle: .alert)
        let done = UIAlertAction(title: "done".localized, style: .default, handler: { action in
            self.dismiss(animated: true, completion: {
                self.listener?.detachLeaderBoard()
            })
        })
        alert.addAction(done)
        present(alert, animated: true, completion: nil)
    }
}

extension LeaderboardViewController: LeaderboardViewControllable {
    
}

extension LeaderboardViewController: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
