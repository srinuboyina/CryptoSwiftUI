//
//  CoinListViewModelTests.swift
//  CryptoSwiftUITests
//
//  Created by apple on 07/02/25.
//

import XCTest
@testable import CryptoSwiftUI

class CoinListViewModelTests: XCTestCase {
    
    var viewModel: CoinListViewModel!
    var networkManager = MockNetworkManager()

    override func setUp() {
        super.setUp()
        viewModel = CoinListViewModel()
        viewModel.networkManager = networkManager
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testLoadCoins() {
        let expectation = self.expectation(description: "Coins should be loaded")
        
        viewModel.onDataUpdate = {
            XCTAssertEqual(self.viewModel.allCoins.count, 100, "Should load exactly 100 coins")
            expectation.fulfill()
        }
        
        viewModel.loadCoins()
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGetCoinsForPage() {
        let mockCoins = (1...50).map { CoinBuilder()
                .with(symbol: "COIN\($0)")
                .with(name: "Coin \($0)")
                .with(change: "\($0 % 10)")
                .build()
            
        }
        networkManager.loadMockCoins(coins: mockCoins)
        viewModel.loadCoins()

        let firstPageCoins = viewModel.getCoinsForPage()
        XCTAssertEqual(firstPageCoins.count, 20, "First page should contain 20 coins")
    }
    
    func testPaginationNextPage() {
        let mockCoins = (1...50).map { CoinBuilder()
                .with(symbol: "COIN\($0)")
                .with(name: "Coin \($0)")
                .with(change: "\($0 % 10)")
                .build()
            
        }
        networkManager.loadMockCoins(coins: mockCoins)
        viewModel.loadCoins()

        viewModel.nextPage()
        let secondPageCoins = viewModel.getCoinsForPage()
        XCTAssertEqual(secondPageCoins.count, 20, "Second page should contain 20 coins")
    }
    
    func testPaginationPreviousPage() {
        let mockCoins = (1...50).map { CoinBuilder()
                .with(symbol: "COIN\($0)")
                .with(name: "Coin \($0)")
                .with(change: "\($0 % 10)")
                .build()
            
        }
        networkManager.loadMockCoins(coins: mockCoins)
        viewModel.loadCoins()

        viewModel.nextPage()
        viewModel.previousPage()
        let firstPageCoins = viewModel.getCoinsForPage()
        XCTAssertEqual(firstPageCoins.count, 20, "After going to next page and back, first page should contain 20 coins")
    }
    
    func testGainers() {
        let mockCoins = [
            CoinBuilder().with(symbol: "BTC").with(name: "Bitcoin").with(change: "10").build(),
            CoinBuilder().with(symbol: "ETH").with(name: "Ethereum").with(change: "-5").build(),
            CoinBuilder().with(symbol: "XRP").with(name: "Ripple").with(change: "20").build(),
        ]
        networkManager.loadMockCoins(coins: mockCoins)
        viewModel.loadCoins()

        let gainers = viewModel.gainers()
        XCTAssertEqual(gainers.count, 2, "Should return 2 gainers")
        XCTAssertEqual(gainers.first?.symbol, "XRP", "XRP should be the top gainer")
    }
    
    func testLoosers() {
        let mockCoins = [
            CoinBuilder().with(symbol: "BTC").with(name: "Bitcoin").with(change: "10").build(),
            CoinBuilder().with(symbol: "ETH").with(name: "Ethereum").with(change: "-5").build(),
            CoinBuilder().with(symbol: "XRP").with(name: "Ripple").with(change: "-20").build(),
        ]
        networkManager.loadMockCoins(coins: mockCoins)
        viewModel.loadCoins()

        let loosers = viewModel.loosers()
        XCTAssertEqual(loosers.count, 2, "Should return 2 loosers")
        XCTAssertEqual(loosers.first?.symbol, "ETH", "Ethereum should be the top loser")
    }
}

