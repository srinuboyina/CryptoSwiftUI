//
//  AppDelegate.swift
//  CryptoCoins
//
//  Created by apple on 29/01/25.
//

import Foundation

struct CoinResponse: Codable {
    let data: CoinData
}

struct CoinData: Codable {
    let coins: [Coin]
}

struct Coin: Codable, Identifiable {
    let id = UUID()
    let name: String
    let price: String
    let iconUrl: String
    let marketCap: String
    let symbol: String
    let volume24h: String
    let change: String
    let sparkline: [String?]
    let btcPrice: String
    let rank: Int
    
    enum CodingKeys: String, CodingKey {
        case name, price, iconUrl, marketCap, symbol, change, rank, sparkline, btcPrice
        case volume24h = "24hVolume"
    }
}

enum TimeFrame: String, CaseIterable {
    case oneDay = "1D"
    case oneWeek = "1W"
    case oneMonth = "1M"
    case oneYear = "1Y"
}
