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
    var solarDate = Date()
    solarDate.year = 2022
    solarDate.month = 12
    solarDate.day = 26
    
    let converter = KoreanLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 2022
    target.month = 12
    target.day = 4
    XCTAssertTrue(convertedDate!.date === target)
    
    
    let formetter = KoreanLunarStringFormatter()
    XCTAssertEqual("2022년 12월 4일(평달)", formetter.lunarDateString(fromSolar: solarDate))
    XCTAssertEqual("임인(壬寅)년 계축(癸丑)월 계축(癸丑)일", formetter.lunarZodiac(fromSolar: solarDate))
    XCTAssertEqual("임인(壬寅)년 계축(癸丑)월 계축(癸丑)일", formetter.lunarZodiac(fromLunar: target))
  }
  
  func testSolarToLunar_2022_06_29() {
    var solarDate = Date()
    solarDate.year = 2017
    solarDate.month = 6
    solarDate.day = 29
    
    let converter = KoreanLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 2017
    target.month = 5
    target.day = 6
    XCTAssertTrue(convertedDate!.date === target)
    
    
    let formetter = KoreanLunarStringFormatter()
    XCTAssertEqual("2017년 5월 6일(윤달)", formetter.lunarDateString(fromSolar: solarDate))
    XCTAssertEqual("정유(丁酉)년 병오(丙午)월 정해(丁亥)일", formetter.lunarZodiac(fromSolar: solarDate))
    XCTAssertEqual("정유(丁酉)년 병오(丙午)월 정해(丁亥)일", formetter.lunarZodiac(fromLunar: target))
  }
  
  func testSolarToLunar_1955_05_05() {
    var solarDate = Date()
    solarDate.year = 1955
    solarDate.month = 5
    solarDate.day = 5
    
    let converter = KoreanLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 1955
    target.month = 3
    target.day = 14
    XCTAssertTrue(convertedDate!.date === target)
    
    
    let formetter = KoreanLunarStringFormatter()
    XCTAssertEqual("1955년 3월 14일(윤달)", formetter.lunarDateString(fromSolar: solarDate))
    XCTAssertEqual("을미(乙未)년 경진(庚辰)월 병인(丙寅)일", formetter.lunarZodiac(fromSolar: solarDate))
    XCTAssertEqual("을미(乙未)년 경진(庚辰)월 병인(丙寅)일", formetter.lunarZodiac(fromLunar: target))
  }
}
