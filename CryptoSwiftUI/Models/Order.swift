//
//  Order.swift
//  CryptoSwiftUI
//
//  Created by apple on 09/02/25.
//

import Foundation

struct Order: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let quantity: Double
    let price: Double
    let total: Double
    let time: String
    let logo: String
}
