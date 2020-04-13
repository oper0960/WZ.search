//
//  LoggedInSearchViewController.swift
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
import GoogleMobileAds
import SnapKit

protocol LoggedInSearchPresentableListener: class {
    // TODO: Business Logic의 수행을 위해 Interactor로 호출할 메소드, 프로퍼티를 구현
    func routeLoggedOut()
}

final class LoggedInSearchViewController: UIViewController {
    
    enum SectionType {
        case header, lifetime, weekly, history
    }
    
    private var menuArray: [SectionType] = []

    weak var listener: LoggedInSearchPresentableListener?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var infomationTableView: UITableView!
    @IBOutlet weak var closeButton: UIButtonCustom!
    @IBOutlet weak var admobView: UIView!
    
    private let indicator = IndicatorView(type: .loading)
    private var infomation: InfomationViewable?
    private var matchs: MatchHistoryViewable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAdmob()
        setTableView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Setup
extension LoggedInSearchViewController {
    func setAdmob() {
        
        var bannerView: GADBannerView!
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
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
    
    private func setTableView() {
        infomationTableView.register(UINib(nibName: "InfomationTableViewHeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        infomationTableView.register(UINib(nibName: "InfomationTableViewSectionHeaderCell", bundle: nil), forCellReuseIdentifier: "SectionHeader")
        infomationTableView.register(UINib(nibName: "InfomationTableViewLifetimeCell", bundle: nil), forCellReuseIdentifier: "LifetimeCell")
        infomationTableView.register(UINib(nibName: "InfomationTableViewWeeklyCell", bundle: nil), forCellReuseIdentifier: "WeeklyCell")
        infomationTableView.register(UINib(nibName: "MatchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        infomationTableView.delegate = self
        infomationTableView.dataSource = self
    }
}

extension LoggedInSearchViewController: LoggedInSearchPresentable {
    
    var onClickCloseButton: ControlEvent<()> {
        return closeButton.rx.controlEvent(.touchUpInside)
    }
    
    func setInfomation(infomation: InfomationViewable, matchs: MatchHistoryViewable? = nil) {
        self.infomation = infomation
        self.matchs = matchs
        
         menuArray = {
            var array = [SectionType]()
            guard let infomation = self.infomation else { return array }
            array.append(.header)
            
            guard infomation.lifetimePlunder != nil || infomation.lifetimeBattleRoyal != nil || infomation.lifetimeAllBattleRoyal != nil else {
                guard let matchs = self.matchs else { return array }
                guard matchs.matchs.count > 0 else {
                    return array
                }
                array.append(.history)
                return array
            }
            array.append(.lifetime)
            
            guard infomation.weeklyPlunder != nil || infomation.weeklyBattleRoyal != nil || infomation.weeklyAllBattleRoyal != nil else {
                guard let matchs = self.matchs else { return array }
                guard matchs.matchs.count > 0 else {
                    return array
                }
                array.append(.history)
                return array
            }
            array.append(.weekly)
            
            guard let matchs = self.matchs else { return array }
            guard matchs.matchs.count > 0 else {
                return array
            }
            array.append(.history)
            
            return array
        }()
        self.infomationTableView.reloadData()
    }
    
    func playLoading() {
        indicator.play(view: self.view)
    }
    
    func stopLoading() {
        indicator.stop()
    }
    
    func showNotAccountAlert() {
        let alert = UIAlertController(title: "not_account_title".localized, message: "not_account_message".localized, preferredStyle: .alert)
        let done = UIAlertAction(title: "done".localized, style: .default, handler: { _ in
            self.listener?.routeLoggedOut()
        })
        alert.addAction(done)
        present(alert, animated: true, completion: nil)
    }
}

extension LoggedInSearchViewController: LoggedInSearchViewControllable {
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LoggedInSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch menuArray[section] {
        case .header:
            return 0
        case .lifetime, .weekly, .history:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "SectionHeader") as! InfomationTableViewSectionHeaderCell
        
        switch menuArray[section] {
        case .header:
            return nil
        case .lifetime:
            headerCell.bind(title: "lifetime".localized)
        case .weekly:
            headerCell.bind(title: "weekly".localized)
        case .history:
            headerCell.bind(title: "matchHistory".localized)
        }
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch menuArray[section] {
        case .header, .lifetime, .weekly:
            return 1
        case .history:
            guard let matchs = self.matchs?.matchs else { return 0 }
            return matchs.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch menuArray[indexPath.section] {
        case .header:
            return 200
        case .lifetime, .weekly:
            return 320
        case .history:
            return 700
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch menuArray[indexPath.section] {
        case .header:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! InfomationTableViewHeaderCell
            
            guard let infomation = infomation else { return headerCell }
            
            headerCell.bind(infomation: infomation)
            
            return headerCell
        case .lifetime:
            let lifetimeCell = tableView.dequeueReusableCell(withIdentifier: "LifetimeCell", for: indexPath) as! InfomationTableViewLifetimeCell
            
            guard let infomation = infomation else { return lifetimeCell }
            
            lifetimeCell.infomation = infomation
            
            return lifetimeCell
        case .weekly:
            let weeklyCell = tableView.dequeueReusableCell(withIdentifier: "WeeklyCell", for: indexPath) as! InfomationTableViewWeeklyCell
            
            guard let infomation = infomation else { return weeklyCell }
            
            weeklyCell.infomation = infomation
            
            return weeklyCell
        case .history:
            let historyCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! MatchHistoryTableViewCell
            guard let matchs = self.matchs?.matchs else { return historyCell }
            
            historyCell.bind(match: matchs[indexPath.row])
            
            return historyCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch menuArray[indexPath.section] {
        case .header, .lifetime, .weekly:
            return
        case .history:
            print("history")
        }
    }
}

extension LoggedInSearchViewController: GADBannerViewDelegate {
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
