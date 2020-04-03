//
//  User.swift
//  Domain
//
//  Created by Gilwan Ryu on 2020/03/04.
//  Copyright © 2020 Gilwan Ryu. All rights reserved.
//

import Foundation

// MARK: - User ViewModel
public protocol UserViewable {
    var id: String? { get }
    var platform: String? { get }
    var updateTime: Date { get }
}
