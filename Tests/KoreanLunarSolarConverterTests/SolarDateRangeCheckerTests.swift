//
//  SolarDateRangeCheckerTests.swift
//  KoreanLunarConverterTests
//
//  Created by SwiftMan on 2022/12/12.
//

import XCTest
@testable import KoreanLunarConverter

final class SolarDateRangeCheckerTests: XCTestCase {
  func testIsValidDate_2034_12_16() {
    var date = Date()
    date.year = 2034
    date.month = 12
    date.day = 26
    
    let checker = SolarDateRangeChecker()
    let isValid = checker.isValidDate(solarDate: date)
    XCTAssertTrue(isValid)
  }
  
  func testIsValidMinDate() {
    var date = Date()
    date.year = 1000
    date.month = 2
    date.day = 13
    date.hour = 0
    date.minute = 0
    date.second = 0
    date.millisecond = 0
    
    let checker = SolarDateRangeChecker()
    let isValid = checker.isValidDate(solarDate: date)
    XCTAssertTrue(isValid)
  }
  
  func testIsNotValidMinDate() {
    var date = Date()
    date.year = 1000
    date.month = 2
    date.day = 12
    
    let checker = SolarDateRangeChecker()
    let isValid = checker.isValidDate(solarDate: date)
    XCTAssertFalse(isValid)
  }
  
  func testIsValidMaxDate() {
    var date = Date()
    date.year = 2050
    date.month = 12
    date.day = 31
    
    let checker = SolarDateRangeChecker()
    let isValid = checker.isValidDate(solarDate: date)
    XCTAssertTrue(isValid)
  }
  
  func testIsNotValidMaxDate() {
    var date = Date()
    date.year = 2051
    date.month = 1
    date.day = 1
    
    let checker = SolarDateRangeChecker()
    let isValid = checker.isValidDate(solarDate: date)
    XCTAssertFalse(isValid)
  }
}
