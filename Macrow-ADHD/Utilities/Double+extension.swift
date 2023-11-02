//
//  Double+extension.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/1/23.
//

import Foundation
extension Double {
    private var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }

    var truncated: String {
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}

