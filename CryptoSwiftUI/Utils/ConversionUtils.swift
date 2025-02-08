//
//  ConversionUtils.swift
//  CryptoCoins
//
//  Created by apple on 02/02/25.
//

import Foundation

extension String {
    
    func toBillion() -> String {
        var result = ""
        if let number = Double(self) {
            if number >= 1_000_000_000 {
                result = String(format: "%.2fB", number / 1_000_000_000)
            } else if number >= 1_000_000 {
                result = String(format: "%.2fM", floor(number / 1_000_000 * 100)/100)
            } else if number >= 1_000 {
                result = String(format: "%.2fK", floor(number / 1_000 * 100) / 100)
            } else {
                result = String(format: "%.2f", number)
            }
            return "#B " + result
        }
        return ""
    }
    
}
