//
//  ConversionUtilTests.swift
//  CryptoSwiftUITests
//
//  Created by apple on 07/02/25.
//

import XCTest
@testable import CryptoSwiftUI

class ConversionUtilTests: XCTestCase {
    
    func testToBillion() {
        XCTAssertEqual("1000000000".toBillion(), "#B 1.00B", "Failed to convert 1B")
        XCTAssertEqual("2500000000".toBillion(), "#B 2.50B", "Failed to convert 2.5B")
        XCTAssertEqual("999999999".toBillion(), "#B 999.99M", "Failed to convert just below 1B")
        
        XCTAssertEqual("1500000".toBillion(), "#B 1.50M", "Failed to convert 1.5M")
        XCTAssertEqual("999999".toBillion(), "#B 999.99K", "Failed to convert just below 1M")
        
        XCTAssertEqual("5000".toBillion(), "#B 5.00K", "Failed to convert 5K")
        XCTAssertEqual("999".toBillion(), "#B 999.00", "Failed to convert just below 1K")
        
        XCTAssertEqual("123.45".toBillion(), "#B 123.45", "Failed to convert decimal number")
        XCTAssertEqual("0".toBillion(), "#B 0.00", "Failed to convert zero")
        
        XCTAssertEqual("abc".toBillion(), "", "Failed to handle non-numeric input")
        XCTAssertEqual("".toBillion(), "", "Failed to handle empty string")
    }
}

