//
//  LunarToSolarTests.swift
//  KoreanLunarConverterTests
//
//  Created by SwiftMan on 2022/12/07.
//

import XCTest
@testable import KoreanLunarConverter

final class LunarToSolarTests: XCTestCase {
  func testLunarToSolar_1956_1_21() {
    var lunarDate = Date()
    lunarDate.year = 1956
    lunarDate.month = 1
    lunarDate.day = 21
    
    let converter = KoreanLunarToSolarConverter()
    let convertedDate = try? converter.solarDate(fromLunar: lunarDate)

    var target = Date()
    target.year = 1956
    target.month = 3
    target.day = 3
    XCTAssertTrue(convertedDate!.date === target)
    
    
    let formetter = KoreanLunarStringFormatter()
    XCTAssertEqual("병신(丙申)년 경인(庚寅)월 기사(己巳)일", formetter.lunarZodiac(fromLunar: lunarDate))
  }
  
  func testLunarToSolar_1914_06_24() {
    var lunarDate = Date()
    lunarDate.year = 1914
    lunarDate.month = 6
    lunarDate.day = 24
    
    let converter = KoreanLunarToSolarConverter()
    let convertedDate = try? converter.solarDate(fromLunar: lunarDate)

    var target = Date()
    target.year = 1914
    target.month = 8
    target.day = 15
    XCTAssertTrue(convertedDate!.date === target)
    
    
    let formetter = KoreanLunarStringFormatter()
    XCTAssertEqual("갑인(甲寅)년 신미(辛未)월 계유(癸酉)일", formetter.lunarZodiac(fromLunar: lunarDate))
  }
  
  func testLunarToSolar_2017_06_29() {
    var lunarDate = Date()
    lunarDate.year = 2017
    lunarDate.month = 6
    lunarDate.day = 29
    
    let converter = KoreanLunarToSolarConverter()
    let convertedDate = try? converter.solarDate(fromLunar: lunarDate)

    var target = Date()
    target.year = 2017
    target.month = 8
    target.day = 20
    XCTAssertTrue(convertedDate!.date === target)
    
    
    let formetter = KoreanLunarStringFormatter()
    XCTAssertEqual("정유(丁酉)년 정미(丁未)월 기묘(己卯)일", formetter.lunarZodiac(fromLunar: lunarDate))
  }
}
