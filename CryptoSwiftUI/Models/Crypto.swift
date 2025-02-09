//
//  Crypto.swift
//  CryptoSwiftUI
//
//  Created by apple on 09/02/25.
//

import Foundation

struct Crypto: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let growth: Double
    let logo: String
}
