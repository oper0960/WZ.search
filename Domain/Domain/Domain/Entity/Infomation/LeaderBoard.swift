//
//  LeaderBoard.swift
//  Domain
//
//  Created by Gilwan Ryu on 2020/04/09.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

public protocol LeaderBoardViewable {
    var rankingType: String { get }
    var players: [PlayerViewable] { get }
}

public protocol PlayerViewable {
    var id: String { get }
    var platform: UIImage { get }
    var avatarUrl: String { get }
    var rank: String { get }
    var matchesPlayedValue: String { get }
}
