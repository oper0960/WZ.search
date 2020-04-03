//
//  DomainEnum.swift
//  Domain
//
//  Created by Gilwan Ryu on 2020/03/18.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

public enum Platform {
    case psn
    case steam
    case battle
    case none
    
    public var name: String {
        switch self {
        case .battle:
            return "battle"
        case .steam:
            return "steam"
        case .psn:
            return "psn"
        case .none:
            return "none"
        }
    }
    
    public var matchHistoryName: String {
        switch self {
        case .battle:
            return "battlenet"
        case .steam:
            return "atvi"
        case .psn:
            return "psn"
        case .none:
            return "atvi"
        }
    }
    
    public init(platform: String) {
        switch platform {
        case "psn":
            self = .psn
        case "steam":
            self = .steam
        case "battle":
            self = .battle
        default:
            self = .none
        }
    }
}
