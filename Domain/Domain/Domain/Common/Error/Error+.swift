//
//  Error+.swift
//  Domain
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

public enum CoreDataFetchError: Error {
    case notContext
}

enum RxError: Error {
    
}

public enum ResponseCode {
    case normal
    case profilePrivate
    case notAccount
    
    public init(code: Int) {
        switch code {
        case 451:
            self = .profilePrivate
        case 404:
            self = .notAccount
        default:
            self = .normal
        }
    }
}
