//
//  AppComponents.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/17.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit
import RIBs

class AppComponents: Component<EmptyDependency>, RootDependency {
    var navigation: UINavigationController

    init() {
        self.navigation = UINavigationController().defaultNavigation()
        super.init(dependency: EmptyComponent())
    }
}
