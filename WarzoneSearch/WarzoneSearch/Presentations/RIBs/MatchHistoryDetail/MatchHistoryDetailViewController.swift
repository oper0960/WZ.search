//
//  MatchHistoryDetailViewController.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/04/27.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import Domain
import SnapKit
import Kingfisher

protocol MatchHistoryDetailPresentableListener: class {
    // TODO: Business Logic의 수행을 위해 Interactor로 호출할 메소드, 프로퍼티를 구현
}

final class MatchHistoryDetailViewController: UIViewController {

    weak var listener: MatchHistoryDetailPresentableListener?
    
    @IBOutlet weak var matchTableView: UITableView!
    
    private var detailData: MatchHistoryDetailViewable? {
        didSet {
            matchTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup
extension MatchHistoryDetailViewController {
    func setup() {
        matchTableView.register(UINib(nibName: "MatchTeamTableViewHeaderCell", bundle: nil), forCellReuseIdentifier: "TeamHeaderCell")
        matchTableView.register(UINib(nibName: "MatchTeamDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamCell")
        matchTableView.register(UINib(nibName: "MatchSoloDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "SoloCell")
        matchTableView.delegate = self
        matchTableView.dataSource = self
    }
    
    func setTableViewHeader() {
        
        guard let data = detailData else { return }
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        
        if let mapUrl = data.mapImageUrl {
            
            let backgroundImageView = UIImageView()
            header.addSubview(backgroundImageView)
            backgroundImageView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
            
            backgroundImageView.kf.setImage(with: ImageResource(downloadURL: mapUrl, cacheKey: mapUrl.absoluteString),
                                        placeholder: nil,
                                        options: nil,
                                        progressBlock: nil)
            { result in

            }
        }
        
        let shadowView = UIView()
        shadowView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        header.addSubview(shadowView)
        shadowView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        let timeStampLabel = UILabel()
        timeStampLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        timeStampLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        timeStampLabel.text = data.timestamp
        timeStampLabel.textAlignment = .right
        header.addSubview(timeStampLabel)
        timeStampLabel.snp.makeConstraints {
            $0.leading.equalTo(header.snp.leading).offset(16)
            $0.trailing.equalTo(header.snp.trailing).offset(-16)
            $0.bottom.equalTo(header.snp.bottom).offset(-20)
        }
        
        let modeNameLabel = UILabel()
        modeNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        modeNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        modeNameLabel.text = data.modeName
        modeNameLabel.textAlignment = .right
        header.addSubview(modeNameLabel)
        modeNameLabel.snp.makeConstraints {
            $0.leading.equalTo(header.snp.leading).offset(16)
            $0.trailing.equalTo(header.snp.trailing).offset(-16)
            $0.bottom.equalTo(timeStampLabel.snp.top).offset(-10)
        }
        
        let mapNamelabel = UILabel()
        mapNamelabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        mapNamelabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        mapNamelabel.text = data.mapName
        mapNamelabel.textAlignment = .right
        header.addSubview(mapNamelabel)
        mapNamelabel.snp.makeConstraints {
            $0.leading.equalTo(header.snp.leading).offset(16)
            $0.trailing.equalTo(header.snp.trailing).offset(-16)
            $0.bottom.equalTo(modeNameLabel.snp.top).offset(-10)
        }
        
        matchTableView.tableHeaderView = header
    }
}

extension MatchHistoryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let teamCount = detailData?.teamPlayers?.count else { return 1 }
        return teamCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let data = detailData else { return nil }
        
        if data.isSolo {
            return nil
        } else {
            guard let teams = detailData?.teamPlayers else { return nil }
            
            let header = tableView.dequeueReusableCell(withIdentifier: "TeamHeaderCell") as! MatchTeamTableViewHeaderCell
            header.rankLabel.text = "#\(teams[section].rank.description)"
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        guard let data = detailData else { return 0 }
        
        if data.isSolo {
            return 0
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailData?.teamPlayers?[section].team.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let data = detailData else { return UITableViewCell() }
        
        if data.isSolo {
            let soloCell = tableView.dequeueReusableCell(withIdentifier: "SoloCell", for: indexPath) as! MatchSoloDetailTableViewCell
            
            guard let rank = data.teamPlayers?[indexPath.section].rank.description, let player = data.teamPlayers?[indexPath.section].team[indexPath.row] else { return soloCell }
            
            soloCell.bind(rank: rank, player: player)
            
            return soloCell
        } else {
            let teamCell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! MatchTeamDetailTableViewCell
            
            guard let player = data.teamPlayers?[indexPath.section].team[indexPath.row] else { return teamCell }
            
            teamCell.bind(player: player)
            
            return teamCell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

extension MatchHistoryDetailViewController: MatchHistoryDetailPresentable {
    func setDetailData(data: MatchHistoryDetailViewable) {
        self.detailData = data
        self.setTableViewHeader()
    }
}

extension MatchHistoryDetailViewController: MatchHistoryDetailViewControllable {
    
}
