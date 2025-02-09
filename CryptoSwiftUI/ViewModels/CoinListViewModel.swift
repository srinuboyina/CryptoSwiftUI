//
//  AppDelegate.swift
//  CryptoCoins
//
//  Created by apple on 29/01/25.
//

import Foundation

protocol CoinListViewModelProtocol {
    func loadCoins()
    var allCoins: [Coin] {get}
    func gainers() -> [Coin]
    func loosers() -> [Coin]
    var onDataUpdate: (() -> Void)? {get set}
    func getCoinsForPage() -> [Coin]
    func nextPage()
    func previousPage()
}


class CoinListViewModel: ObservableObject, CoinListViewModelProtocol {
    private var coins: [Coin] = []
    private let pageSize = 20
    private var currentPage = 0

    var onDataUpdate: (() -> Void)?

    var networkManager: NetworkManagerProtocol = NetworkManager.shared
    
    func loadCoins() {
        networkManager.fetchCoins { result in
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
    
    var allCoins: [Coin] {
        return coins
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
}
