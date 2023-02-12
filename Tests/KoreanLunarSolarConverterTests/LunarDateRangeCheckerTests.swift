//
//  LunarDateRangeCheckerTests.swift
//  KoreanLunarConverterTests
//
//  Created by SwiftMan on 2022/12/12.
//

import XCTest
import KoreanLunarSolarConverter

final class LunarDateRangeCheckerTests: XCTestCase {
  func testIsValidDate_2022_12_16() {
    var date = Date()
    date.year = 2022
    date.month = 12
    date.day = 26
    
    let checker = LunarDateRangeChecker()
    let isValid = checker.isValidDate(lunarDate: date)
    XCTAssertTrue(isValid)
  }
  
  func testIsValidDate_1000_01_01() {
    var date = Date()
    date.year = 1000
    date.month = 1
    date.day = 1
    
    let checker = LunarDateRangeChecker()
    let isValid = checker.isValidDate(lunarDate: date)
    XCTAssertTrue(isValid)
  }
  
  func testIsNotValidMinDate() {
    var date = Date()
    date.year = 999
    date.month = 12
    date.day = 31
    
    let checker = LunarDateRangeChecker()
    let isValid = checker.isValidDate(lunarDate: date)
    XCTAssertFalse(isValid)
  }
  
  func testIsValidMaxDate() {
    var date = Date()
    date.year = 2050
    date.month = 11
    date.day = 18
    
    let checker = LunarDateRangeChecker()
    let isValid = checker.isValidDate(lunarDate: date)
    XCTAssertTrue(isValid)
  }
  
  func testIsNotValidMaxDate() {
    var date = Date()
    date.year = 2050
    date.month = 11
    date.day = 19
    
    let checker = LunarDateRangeChecker()
    let isValid = checker.isValidDate(lunarDate: date)
    XCTAssertFalse(isValid)
  }
}
