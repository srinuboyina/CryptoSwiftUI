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

struct Coin: Codable, Identifiable, Equatable {
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
    
    init(name: String, price: String, iconUrl: String, marketCap: String, symbol: String, volume24h: String, change: String, sparkline: [String?], btcPrice: String, rank: Int) {
        self.name = name
        self.price = price
        self.iconUrl = iconUrl
        self.marketCap = marketCap
        self.symbol = symbol
        self.volume24h = volume24h
        self.change = change
        self.sparkline = sparkline
        self.btcPrice = btcPrice
        self.rank = rank
    }
    
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
