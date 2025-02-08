//
//  CoinBuilder.swift
//  CryptoSwiftUITests
//
//  Created by apple on 08/02/25.
//

import Foundation
@testable import CryptoSwiftUI

class CoinBuilder  {
    private var id = UUID()
    private var name: String = "Bitcoin"
    private var price: String = "96676.83313749699"
    private var iconUrl: String = "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg"
    private var marketCap: String = "52414124"
    private var symbol: String = "BTC"
    private var volume24h: String = "42708241341"
    private var change: String  = "-0.81"
    private var sparkline: [String?] = [
        "97486.36155361694",
        "97626.25221965743",
        "97358.63733040547",
        "97024.54234755224",
        "96915.33671700745",
        "96933.86041925829",
        "97270.5837593875",
        "97374.33253119695",
        "97600.46891611829",
        "97822.8371199939",
        "98001.41126717468",
        "99587.55496485943",
        "98617.01568251994",
        "98062.42972867689",
        "97670.30886660154",
        "97911.44005284877",
        "97325.3545301519",
        "96262.0538177808",
        "95911.65561486437",
        "95837.21915863939",
        "96254.2501856977",
        "96622.9403877612",
        "96669.59047670319",
        "96598.86084050006"
    ]
    private var btcPrice: String = "1"
    private var rank: Int = 1
    
    func with(name: String)  -> CoinBuilder{
        self.name = name
        return self
    }
    
    func with(price: String)  -> CoinBuilder{
        self.price = price
        return self
    }
    
    func with(iconUrl: String)  -> CoinBuilder{
        self.iconUrl = iconUrl
        return self
    }
    
    func with(marketCap: String)  -> CoinBuilder{
        self.marketCap = marketCap
        return self
    }
    
    func with(symbol: String)  -> CoinBuilder{
        self.symbol = symbol
        return self
    }
    
    func with(volume24h: String)  -> CoinBuilder{
        self.volume24h = volume24h
        return self
    }
    
    func with(change: String)  -> CoinBuilder{
        self.change = change
        return self
    }
    
    func with(sparkline: [String])  -> CoinBuilder{
        self.sparkline = sparkline
        return self
    }
    
    func with(btcPrice: String)  -> CoinBuilder{
        self.btcPrice = btcPrice
        return self
    }
    
    func with(rank: Int)  -> CoinBuilder{
        self.rank = rank
        return self
    }
    
    func build() -> Coin  {
        return Coin(name: name, price: price, iconUrl: iconUrl, marketCap: marketCap, symbol: symbol, volume24h: volume24h, change: change, sparkline: sparkline, btcPrice: btcPrice, rank: rank)
    }
}
