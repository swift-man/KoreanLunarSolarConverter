//
//  SolarToLunarTests.swift
//  KoreanLunarConverterTests
//
//  Created by SwiftMan on 2022/12/07.
//

import XCTest
@testable import KoreanLunarConverter

final class SolarToLunarTests: XCTestCase {
  func testSolarToLunar_2022_12_16() {
    let converter = KoreanLunarConverter()
    converter.solarDate(solarYear: 2022, solarMonth: 12, solarDay: 26)
    
    var result = Date()
    result.year = 2022
    result.month = 12
    result.day = 4
    XCTAssertTrue(converter.lunarDate === result)
    XCTAssertEqual("임인(壬寅)년 계축(癸丑)월 계축(癸丑)일", converter.lunarZodiac)
  }
  
  func testSolarToLunar_2022_06_29() {
    let converter = KoreanLunarConverter()
    converter.solarDate(solarYear: 2017, solarMonth: 6, solarDay: 29)
    
    var result = Date()
    result.year = 2017
    result.month = 5
    result.day = 6
    XCTAssertTrue(converter.lunarDate === result)
    XCTAssertEqual("2017년 5월 6일(윤달)", converter.lunarDateString)
    XCTAssertEqual("정유(丁酉)년 병오(丙午)월 정해(丁亥)일", converter.lunarZodiac)
  }
}
