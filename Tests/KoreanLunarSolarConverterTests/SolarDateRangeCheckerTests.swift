//
//  SolarDateRangeCheckerTests.swift
//  KoreanLunarConverterTests
//
//  Created by SwiftMan on 2022/12/12.
//

import Testing
import Foundation
@testable import KoreanLunarSolarConverter

struct SolarDateRangeCheckerTests {
  let checker = KoreanSolarDateRangeChecker()

  @Test
  func testIsValidDate_2034_12_16() {
    var date = Date()
    date.year = 2034
    date.month = 12
    date.day = 26
    
    let isValid = checker.isValidDate(solarDate: date)
    #expect(isValid)
  }

  @Test
  func testIsNotValidMinDate() {
    var date = Date()
    date.year = 1949
    date.month = 2
    date.day = 13
    date.hour = 0
    date.minute = 0
    date.second = 0
    date.millisecond = 0
    
    let isValid = checker.isValidDate(solarDate: date)
    #expect(!isValid)
  }

  @Test
  func testIsNotValidMinDate2() {
    var date = Date()
    date.year = 1000
    date.month = 2
    date.day = 12
    
    let isValid = checker.isValidDate(solarDate: date)
    #expect(!isValid)
  }

  @Test
  func testIsValidMaxDate() {
    var date = Date()
    date.year = 2036
    date.month = 12
    date.day = 30
    
    let isValid = checker.isValidDate(solarDate: date)
    #expect(isValid)
  }

  @Test
  func testIsNotValidMaxDate() {
    var date = Date()
    date.year = 2051
    date.month = 1
    date.day = 1
    
    let isValid = checker.isValidDate(solarDate: date)
    #expect(!isValid)
  }
}
