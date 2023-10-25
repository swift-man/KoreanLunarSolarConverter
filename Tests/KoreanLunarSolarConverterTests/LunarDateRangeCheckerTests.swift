//
//  LunarDateRangeCheckerTests.swift
//  KoreanLunarConverterTests
//
//  Created by SwiftMan on 2022/12/12.
//

import XCTest
import KoreanLunarSolarConverter

final class LunarDateRangeCheckerTests: XCTestCase {
  let checker = KoreanLunarDateRangeChecker()
  
  func testIsValidDate_2022_12_16() {
    var date = Date()
    date.year = 2022
    date.month = 12
    date.day = 26
    
    
    let isValid = checker.isValidDate(lunarDate: date)
    XCTAssertTrue(isValid)
  }
  
  func testIsValidDate_1000_01_01() {
    var date = Date()
    date.year = 1000
    date.month = 1
    date.day = 1
    
    let isValid = checker.isValidDate(lunarDate: date)
    XCTAssertTrue(isValid)
  }
  
  func testIsNotValidMinDate() {
    var date = Date()
    date.year = 999
    date.month = 12
    date.day = 31
    
    let isValid = checker.isValidDate(lunarDate: date)
    XCTAssertFalse(isValid)
  }
  
  func testIsValidMaxDate() {
    var date = Date()
    date.year = 2050
    date.month = 11
    date.day = 18
    
    let isValid = checker.isValidDate(lunarDate: date)
    XCTAssertTrue(isValid)
  }
  
  func testIsNotValidMaxDate() {
    var date = Date()
    date.year = 2050
    date.month = 11
    date.day = 19
    
    let isValid = checker.isValidDate(lunarDate: date)
    XCTAssertFalse(isValid)
  }
  
  // 시간, 분, 초는 날짜의 유효성에 영향을 미치지 않아야 합니다.
  func testIsValidWithDifferentTime() {
    var date = Date()
    date.year = 2022
    date.month = 1
    date.day = 15
    date.hour = 12
    date.minute = 30
    date.second = 45
    
    let isValid = checker.isValidDate(lunarDate: date)
    XCTAssertTrue(isValid)
  }
  
  func testAlgorithmChange() {
    var date = Date()
    date.year = 2025
    date.month = 2
    date.day = 28
    
    let isValid = checker.isValidDate(lunarDate: date)
    XCTAssertTrue(isValid)
  }
}
