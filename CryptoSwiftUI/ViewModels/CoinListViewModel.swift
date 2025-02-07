//
//  AppDelegate.swift
//  CryptoCoins
//
//  Created by apple on 29/01/25.
//

import Foundation


class CoinListViewModel: ObservableObject {
    private var coins: [Coin] = []
    private let pageSize = 20
    private var currentPage = 0

    var onDataUpdate: (() -> Void)?

    func loadCoins() {
        NetworkManager.shared.fetchCoins { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self.coins = Array(coins.prefix(100)) // Fetch top 100 coins
                    self.onDataUpdate?()
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                }
            }
        }
    }

    func getCoinsForPage() -> [Coin] {
        let start = currentPage * pageSize
        let end = min(start + pageSize, coins.count)
        return Array(coins[start..<end])
    }

    func nextPage() {
        if (currentPage + 1) * pageSize < coins.count {
            currentPage += 1
            onDataUpdate?()
        }
    }

    func previousPage() {
        if currentPage > 0 {
            currentPage -= 1
            onDataUpdate?()
        }
    }
    
    func gainers() -> [Coin] {
        return coins.filter ({ Double($0.change) ?? 0 >= 0} ).sorted { coin1, coin2 in
            return coin1.change > coin2.change
        }
    }
    
    func loosers() -> [Coin] {
        return coins.filter ({ Double($0.change) ?? 0 < 0} ).sorted { coin1, coin2 in
            return coin1.change > coin2.change
        }
    }
    
    static func addFavourite(coin: Coin){
        if let encoded = try? JSONEncoder().encode([coin]) {
            if var favorites = getFavoriteCoins() {
                favorites.append(coin)
                let encodedCoins = try? JSONEncoder().encode(favorites)
                UserDefaults.standard.set(encodedCoins, forKey: "favoriteCoins")
            } else {
                UserDefaults.standard.set(encoded, forKey: "favoriteCoins")
            }
        }
    }
    
    static func getFavoriteCoins() -> [Coin]? {
        if let savedData = UserDefaults.standard.data(forKey: "favoriteCoins"),
           let decoded = try? JSONDecoder().decode([Coin].self, from: savedData) {
            return decoded
        }
        return nil
    }
}
