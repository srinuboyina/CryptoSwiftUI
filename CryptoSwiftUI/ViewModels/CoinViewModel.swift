//
//  CoinViewModel.swift
//  CryptoCoins
//
//  Created by apple on 02/02/25.
//

import Foundation

protocol CoinViewModelProtocol {
    var marketCap: String {get}
    var price: String {get}
    var name: String {get}
    var symbol: String {get}
    var volume24h: String {get}
    var change: String {get}
    var iconUrl: String {get}
    var sparkline: [Double] {get}
    var rank: String {get}
    var btcPrice: String {get}
    func getCoin() -> Coin
    func chartData() ->[(x:Double, y:Double)]
    var favorite: Bool {get set}
}


class CoinViewModel: ObservableObject, CoinViewModelProtocol {
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
    
    func chartData() ->[(x:Double, y:Double)]{
        let formattedData = sparkline.enumerated().compactMap { (index, value) in
            (x: Double(index + 1), y: Double(value))
        }
        return formattedData
    }
    
    var favorite: Bool {
        get {
            if let favorites = FavoriteService.shared.getAllFavorites() {
                if favorites.first(where: { coin1 in
                    return coin.symbol == coin1.symbol
                }) != nil  {
                    return true
                }
            }
            
            return false
        }
        set(newValue) {
            if newValue {
                FavoriteService.shared.addFavorite(coin: coin)
            } else {
                FavoriteService.shared.removeFavorite(coin: coin)
            }
        }
    }
    
    

}

