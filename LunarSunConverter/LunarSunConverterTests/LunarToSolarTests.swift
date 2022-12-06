//
//  LunarToSolarTests.swift
//  LunarSunConverterTests
//
//  Created by SwiftMan on 2022/12/07.
//

import XCTest
@testable import LunarSunConverter

final class LunarToSolarTests: XCTestCase {
  func testLunarToSolar_1956_1_21() {
    let converter = KoreanLunarConverter()
    converter.lunarDate(lunarYear: 1956, lunarMonth: 1, lunarDay: 21, isIntercalation: false)

    var result = Date()
    result.year = 1956
    result.month = 3
    result.day = 3
    XCTAssertTrue(converter.solarDate === result)
    XCTAssertEqual("병신(丙申)년 경인(庚寅)월 기사(己巳)일", converter.lunarZodiac)
  }
  
  func testLunarToSolar_1914_06_24() {
    let converter = KoreanLunarConverter()
    converter.lunarDate(lunarYear: 1914, lunarMonth: 6, lunarDay: 24, isIntercalation: false)
    
    var result = Date()
    result.year = 1914
    result.month = 8
    result.day = 15
    XCTAssertTrue(converter.solarDate === result)
    XCTAssertEqual("갑인(甲寅)년 신미(辛未)월 계유(癸酉)일", converter.lunarZodiac)
  }
  
  func testLunarToSolar_2017_06_29() {
    let converter = KoreanLunarConverter()
    converter.lunarDate(lunarYear: 2017, lunarMonth: 6, lunarDay: 29, isIntercalation: false)

    var result = Date()
    result.year = 2017
    result.month = 8
    result.day = 20
    
    XCTAssertTrue(converter.solarDate === result)
    XCTAssertEqual("정유(丁酉)년 정미(丁未)월 기묘(己卯)일", converter.lunarZodiac)
  }
}
