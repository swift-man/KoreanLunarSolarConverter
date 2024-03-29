//
//  SolarToLunarTests.swift
//  KoreanLunarConverterTests
//
//  Created by SwiftMan on 2022/12/07.
//

import XCTest
import KoreanLunarSolarConverter

final class SolarToLunarTests: XCTestCase {
  func testSolarToLunar_2022_12_16() {
    var solarDate = Date()
    solarDate.year = 2022
    solarDate.month = 12
    solarDate.day = 26
    
    let converter = KoreanSolarToLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 2022
    target.month = 12
    target.day = 4
    XCTAssertTrue(convertedDate!.date === target)
    
    
    let formetter = KoreanLunarStringFormatter()
    XCTAssertEqual("2022년 12월 4일(평달)", try? formetter.lunarDateString(fromSolar: solarDate))
    XCTAssertEqual("임인(壬寅)년 계축(癸丑)월 계축(癸丑)일", try? formetter.lunarZodiac(fromSolar: solarDate))
    XCTAssertEqual("임인(壬寅)년 계축(癸丑)월 계축(癸丑)일", formetter.lunarZodiac(fromLunar: target))
  }
  
  func testSolarToLunar_2022_06_29() {
    var solarDate = Date()
    solarDate.year = 2017
    solarDate.month = 6
    solarDate.day = 29
    
    let converter = KoreanSolarToLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 2017
    target.month = 5
    target.day = 6
    XCTAssertTrue(convertedDate!.date === target)
    
    
    let formetter = KoreanLunarStringFormatter()
    XCTAssertEqual("2017년 5월 6일(윤달)", try? formetter.lunarDateString(fromSolar: solarDate))
    XCTAssertEqual("정유(丁酉)년 병오(丙午)월 정해(丁亥)일", try? formetter.lunarZodiac(fromSolar: solarDate))
    XCTAssertEqual("정유(丁酉)년 병오(丙午)월 정해(丁亥)일", formetter.lunarZodiac(fromLunar: target))
  }
  
  func testSolarToLunar_1955_05_05() {
    var solarDate = Date()
    solarDate.year = 1955
    solarDate.month = 5
    solarDate.day = 5
    
    let converter = KoreanSolarToLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 1955
    target.month = 3
    target.day = 14
    XCTAssertTrue(convertedDate!.date === target)
    
    
    let formetter = KoreanLunarStringFormatter()
    XCTAssertEqual("1955년 3월 14일(윤달)", try? formetter.lunarDateString(fromSolar: solarDate))
    XCTAssertEqual("을미(乙未)년 경진(庚辰)월 병인(丙寅)일", try? formetter.lunarZodiac(fromSolar: solarDate))
    XCTAssertEqual("을미(乙未)년 경진(庚辰)월 병인(丙寅)일", formetter.lunarZodiac(fromLunar: target))
  }
  
  func testSolarToLunar_1985_07_10() {
    var solarDate = Date()
    solarDate.year = 1985
    solarDate.month = 7
    solarDate.day = 10
    
    let converter = KoreanSolarToLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 1985
    target.month = 5
    target.day = 23
    XCTAssertTrue(convertedDate!.date === target)
    
    
    let formetter = KoreanLunarStringFormatter()
    XCTAssertEqual("1985년 5월 23일(평달)", try? formetter.lunarDateString(fromSolar: solarDate))
    XCTAssertEqual("을축(乙丑)년 임오(壬午)월 경술(庚戌)일", try? formetter.lunarZodiac(fromSolar: solarDate))
    XCTAssertEqual("을축(乙丑)년 임오(壬午)월 경술(庚戌)일", formetter.lunarZodiac(fromLunar: target))
  }
  
  func testSolarToLunar_1982_09_20() {
    var solarDate = Date()
    solarDate.year = 1982
    solarDate.month = 9
    solarDate.day = 20
    
    let converter = KoreanSolarToLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 1982
    target.month = 8
    target.day = 4
    XCTAssertTrue(convertedDate!.date === target)
    
    
    let formetter = KoreanLunarStringFormatter()
    XCTAssertEqual("1982년 8월 4일(평달)", try? formetter.lunarDateString(fromSolar: solarDate))
    XCTAssertEqual("임술(壬戌)년 기유(己酉)월 병오(丙午)일", try? formetter.lunarZodiac(fromSolar: solarDate))
    XCTAssertEqual("임술(壬戌)년 기유(己酉)월 병오(丙午)일", formetter.lunarZodiac(fromLunar: target))
  }
  
  func testSolarToLunar_2018_10_08() {
    var solarDate = Date()
    solarDate.year = 2018
    solarDate.month = 10
    solarDate.day = 8
    
    let converter = KoreanSolarToLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 2018
    target.month = 8
    target.day = 29
    XCTAssertTrue(convertedDate!.date === target)
    
    
    let formetter = KoreanLunarStringFormatter()
    XCTAssertEqual("2018년 8월 29일(평달)", try? formetter.lunarDateString(fromSolar: solarDate))
    XCTAssertEqual("무술(戊戌)년 신유(辛酉)월 계유(癸酉)일", try? formetter.lunarZodiac(fromSolar: solarDate))
    XCTAssertEqual("무술(戊戌)년 신유(辛酉)월 계유(癸酉)일", formetter.lunarZodiac(fromLunar: target))
  }
  
  func testSolarToLunar_2023_01_01() {
    var solarDate = Date()
    solarDate.year = 2023
    solarDate.month = 1
    solarDate.day = 1
    
    let converter = KoreanSolarToLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 2022
    target.month = 12
    target.day = 10
    XCTAssertTrue(convertedDate!.date === target)
    
    
    let formetter = KoreanLunarStringFormatter()
    XCTAssertEqual("2022년 12월 10일(평달)", try? formetter.lunarDateString(fromSolar: solarDate))
    XCTAssertEqual("임인(壬寅)년 계축(癸丑)월 기미(己未)일", try? formetter.lunarZodiac(fromSolar: solarDate))
    XCTAssertEqual("임인(壬寅)년 계축(癸丑)월 기미(己未)일", formetter.lunarZodiac(fromLunar: target))
  }
  
  func testSolarToLunar_2023_02_19() {
    var solarDate = Date()
    solarDate.year = 2023
    solarDate.month = 2
    solarDate.day = 19
    
    let converter = KoreanSolarToLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 2023
    target.month = 1
    target.day = 29
    XCTAssertTrue(convertedDate!.date === target)
  }
  
  func testSolarToLunar_2023_03_21() {
    var solarDate = Date()
    solarDate.year = 2023
    solarDate.month = 3
    solarDate.day = 21
    
    let converter = KoreanSolarToLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 2023
    target.month = 2
    target.day = 30
    print("2.30 : \(target)")
    XCTAssertTrue(convertedDate!.date === target)
  }
  
  func testSolarToLunar_2023_04_20() {
    var solarDate = Date()
    solarDate.year = 2023
    solarDate.month = 4
    solarDate.day = 20
    
    let converter = KoreanSolarToLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 2023
    target.month = 3
    target.day = 1
    XCTAssertTrue(convertedDate!.date === target)
  }
  
  func testSolarToLunar_2023_5_21() {
    var solarDate = Date()
    solarDate.year = 2023
    solarDate.month = 5
    solarDate.day = 21
    
    let converter = KoreanSolarToLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 2023
    target.month = 4
    target.day = 2
    XCTAssertTrue(convertedDate!.date === target)
  }
  
  func testSolarToLunar_2024_01_20() {
    var solarDate = Date()
    solarDate.year = 2024
    solarDate.month = 1
    solarDate.day = 20
    
    let converter = KoreanSolarToLunarConverter()
    let convertedDate = try? converter.lunarDate(fromSolar: solarDate)

    var target = Date()
    target.year = 2023
    target.month = 12
    target.day = 10
    XCTAssertTrue(convertedDate!.date === target)
  }
}
