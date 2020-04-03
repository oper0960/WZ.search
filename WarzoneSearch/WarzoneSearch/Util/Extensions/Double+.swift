//
//  Double+.swift
//  WarzoneSearch
//
//  Created by Gilwan Ryu on 2020/03/23.
//  Copyright © 2020 GilwanRyu. All rights reserved.
//

import UIKit

extension Double {
    var groupingSeparator: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return "\(numberFormatter.string(from: self as NSNumber)!)"
    }
}
