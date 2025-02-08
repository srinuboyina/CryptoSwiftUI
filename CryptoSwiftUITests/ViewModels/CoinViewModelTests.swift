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
    
    func testChartData() {
        // Given: A mock sparkline array
        let sparklineData = ["1.23", "2.34", "3.45", "4.56"]
        let mockCoin = CoinBuilder()
                            .with(symbol: "BTC")
                            .with(name: "Bitcoin")
                            .with(change: "1.5")
                            .with(marketCap: "1000000")
                            .with(price: "50000")
                            .with(volume24h: "100000")
                            .with(iconUrl: "")
                            .with(sparkline: sparklineData)
                            .with(rank: 1)
                            .with(btcPrice: "1.0")
                            .build()
        let viewModel = CoinViewModel(coin: mockCoin)
        
        // When: Calling chartData()
        let result = viewModel.chartData()
        
        // Then: Validate the output
        XCTAssertEqual(result.count, sparklineData.count, "chartData count mismatch")
        
        // Check if x-values start from 1 and increment
        for (index, dataPoint) in result.enumerated() {
            XCTAssertEqual(dataPoint.x, Double(index + 1), "X value mismatch at index \(index)")
            XCTAssertEqual(dataPoint.y, Double(sparklineData[index]), "Y value mismatch at index \(index)")
        }
    }

}
