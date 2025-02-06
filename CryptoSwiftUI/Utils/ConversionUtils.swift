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
                result = String(format: "%.2fM", number / 1_000_000)
            } else if number >= 1_000 {
                result = String(format: "%.2fK", number / 1_000)
            } else {
                result = String(format: "%.2f", number)
            }
            return "#B " + result
        }
        return ""
    }
    
}
