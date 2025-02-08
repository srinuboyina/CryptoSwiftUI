//
//  CoinViewModelTests.swift
//  CryptoSwiftUITests
//
//  Created by apple on 08/02/25.
//

import XCTest
@testable import CryptoSwiftUI  // Replace with your actual module name

class CoinViewModelTests: XCTestCase {

    var viewModel: CoinViewModel!
    var mockCoin: Coin!

    override func setUp() {
        super.setUp()
        mockCoin = Coin(
            name: "Bitcoin", price: "1000", iconUrl: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg", marketCap: "50000", symbol: "BTC", volume24h: "42708241341", change: "-2.5%", sparkline: ["50000", "50500", "49000"], btcPrice: "1.0", rank: 1)

        viewModel = CoinViewModel(coin: mockCoin)
    }

    override func tearDown() {
        viewModel = nil
        mockCoin = nil
        super.tearDown()
    }

    // MARK: - ✅ Basic Properties Tests

    func testCoinName() {
        XCTAssertEqual(viewModel.name, "Bitcoin")
    }

    func testCoinSymbol() {
        XCTAssertEqual(viewModel.symbol, "BTC")
    }

    func testCoinRank() {
        XCTAssertEqual(viewModel.rank, "1")
    }

    func testCoinBtcPrice() {
        XCTAssertEqual(viewModel.btcPrice, "1.0")
    }

    // MARK: - ✅ Number Formatting Tests

    func testMarketCapFormatting() {
        XCTAssertEqual(viewModel.marketCap, "#B 50.00K")
    }

    func testPriceFormatting() {
        XCTAssertEqual(viewModel.price, "#B 1.00K")
    }

    func testVolumeFormatting() {
        XCTAssertEqual(viewModel.volume24h, "#B 42.71B")
    }

    // MARK: - ✅ Sparkline Conversion Tests

    func testSparklineConversion() {
        XCTAssertEqual(viewModel.sparkline, [50000, 50500, 49000])
    }

    // MARK: - ✅ Favorite Toggle Tests

    func testFavoriteToggle() {
        FavoriteService.shared.removeFavorite(coin: mockCoin) // Ensure it's not a favorite

        viewModel.favorite = true // Add to favorites
        XCTAssertTrue(viewModel.favorite)

        viewModel.favorite = false // Remove from favorites
        XCTAssertFalse(viewModel.favorite)
    }

}
