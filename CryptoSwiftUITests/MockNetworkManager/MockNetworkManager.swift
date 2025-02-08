//
//  MockNetworkManager.swift
//  CryptoSwiftUITests
//
//  Created by apple on 08/02/25.
//

import Foundation
@testable import CryptoSwiftUI

class MockNetworkManager: NetworkManagerProtocol {
    var mockCoins: [Coin] = []
    func fetchCoins(completion: @escaping (Result<[Coin], Error>) -> Void) {
        // Creating mock data
        if mockCoins.isEmpty {
            loadMockCoins()
        }
        completion(.success(mockCoins))
    }
    
    func loadMockCoins(coins:[Coin]) {
        mockCoins = coins
    }
    
    func loadMockCoins() {
        mockCoins = (1...100).map { CoinBuilder()
                                            .with(symbol: "COIN\($0)")
                                            .with(name: "Coin \($0)")
                                            .with(change: "\($0 % 10)")
                                            .build()
        }
    }
}
