//
//  CoinViewModel.swift
//  CryptoCoins
//
//  Created by apple on 02/02/25.
//

import Foundation


class CoinViewModel: ObservableObject {
    @Published private var coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var marketCap: String {
        return coin.marketCap.toBillion()
    }
    
    var price: String {
        return coin.price.toBillion()
    }
    
    var name: String {
        return coin.name
    }
    
    var symbol: String {
        return coin.symbol
    }
    
    var volume24h: String {
        return coin.volume24h.toBillion()
    }
    
    var change: String {
        return coin.change
    }
    
    var iconUrl: String {
        return coin.iconUrl
    }
    
    var sparkline: [Double] {
        let prices =  coin.sparkline.compactMap({ Double($0 ?? "0") })
        return prices
    }
    
    var rank: String {
        return String(coin.rank)
    }
    
    var btcPrice: String {
        return coin.btcPrice
    }
    
    func getCoin() -> Coin {
        return coin
    }

}
