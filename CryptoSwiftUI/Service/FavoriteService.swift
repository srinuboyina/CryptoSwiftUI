//
//  FavoriteService.swift
//  CryptoSwiftUI
//
//  Created by apple on 07/02/25.
//

import Foundation

protocol FavoriteServiceProtocol {
    func addFavorite(coin: Coin)
    func removeFavorite(coin: Coin)
    func getAllFavorites() -> [Coin]?
}

class FavoriteService: FavoriteServiceProtocol {
    
    static let shared = FavoriteService()
    
    private init() {}
    
    func addFavorite(coin: Coin) {
        if let encoded = try? JSONEncoder().encode([coin]) {
            if var favorites = getAllFavorites() {
                favorites.append(coin)
                let encodedCoins = try? JSONEncoder().encode(favorites)
                UserDefaults.standard.set(encodedCoins, forKey: "favoriteCoins")
            } else {
                UserDefaults.standard.set(encoded, forKey: "favoriteCoins")
            }
        }
    }
    
    func removeFavorite(coin: Coin) {
        if var favorites = getAllFavorites() {
            favorites.removeAll(where: { coin1 in
                coin1.symbol == coin.symbol
            })
            let encodedCoins = try? JSONEncoder().encode(favorites)
            UserDefaults.standard.set(encodedCoins, forKey: "favoriteCoins")
        }
    }
    
    func getAllFavorites() -> [Coin]? {
        if let savedData = UserDefaults.standard.data(forKey: "favoriteCoins"),
           let decoded = try? JSONDecoder().decode([Coin].self, from: savedData) {
            return decoded
        }
        return nil
    }
}
