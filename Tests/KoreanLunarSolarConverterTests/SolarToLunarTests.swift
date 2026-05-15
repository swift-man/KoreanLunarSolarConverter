//
//  SolarToLunarTests.swift
//  KoreanLunarConverterTests
//
//  Created by SwiftMan on 2022/12/07.
//

import Testing
import Foundation
@testable import KoreanLunarSolarConverter

struct SolarToLunarTests {
  @Test
  func testSolarToLunar_2022_12_16() {
    var solarDate = Date()
    solarDate.year = 2022
    solarDate.month = 12
    solarDate.day = 26

    let output = LunarDate(
      year: 2022,
      month: 12,
      day: 4,
      isIntercalation: false
    )

    expect(
      input: solarDate,
      output: output,
      formattedString: "2022년 12월 4일(평달)",
      zodiac: "임인(壬寅)년 계축(癸丑)월 계축(癸丑)일"
    )
  }

  private func expect(
    input: Date,
    output: LunarDate,
    formattedString: String,
    zodiac: String
  ) {
    do {
      let converter = try KoreanSolarToLunarConverter()
      let convertedDate = try converter.lunarDate(fromSolar: input)

      #expect(convertedDate == output)

      let formetter = try KoreanLunarStringFormatter()
      let value1 = try formetter.lunarDateString(fromSolar: input)
      #expect(formattedString == value1)

      let value2 = try formetter.lunarZodiac(fromSolar: input)
      #expect(value2 == zodiac)

    } catch {
      Issue.record("변환 중 에러 발생: \(error)")
    }
  }

  @Test
  func testSolarToLunar_2017_06_29() {
    var solarDate = Date()
    solarDate.year = 2017
    solarDate.month = 6
    solarDate.day = 29

    let output = LunarDate(
      year: 2017,
      month: 5,
      day: 6,
      isIntercalation: true
    )

    expect(
      input: solarDate,
      output: output,
      formattedString: "2017년 5월 6일(윤달)",
      zodiac: "정유(丁酉)년 병오(丙午)월 정해(丁亥)일"
    )
  }

  @Test
  func testSolarToLunar_2018_05_23() {
    var solarDate = Date()
    solarDate.year = 2018
    solarDate.month = 5
    solarDate.day = 23

    let output = LunarDate(
      year: 2018,
      month: 4,
      day: 9,
      isIntercalation: false
    )

    expect(
      input: solarDate,
      output: output,
      formattedString: "2018년 4월 9일(평달)",
      zodiac: "무술(戊戌)년 정사(丁巳)월 을묘(乙卯)일"
    )
  }

  @Test
  func testSolarToLunar_2026_07_10() {
    var solarDate = Date()
    solarDate.year = 2026
    solarDate.month = 7
    solarDate.day = 10

    let output = LunarDate(
      year: 2026,
      month: 5,
      day: 26,
      isIntercalation: false
    )

    expect(
      input: solarDate,
      output: output,
      formattedString: "2026년 5월 26일(평달)",
      zodiac: "병오(丙午)년 갑오(甲午)월 을유(乙酉)일"
    )
  }

  @Test
  func testSolarToLunar_2026_09_20() {
    var solarDate = Date()
    solarDate.year = 2026
    solarDate.month = 9
    solarDate.day = 20

    let output = LunarDate(
      year: 2026,
      month: 8,
      day: 10,
      isIntercalation: false
    )

    expect(
      input: solarDate,
      output: output,
      formattedString: "2026년 8월 10일(평달)",
      zodiac: "병오(丙午)년 정유(丁酉)월 정유(丁酉)일"
    )
  }

  @Test
  func testSolarToLunar_2018_10_08() {
    var solarDate = Date()
    solarDate.year = 2018
    solarDate.month = 10
    solarDate.day = 8

    let output = LunarDate(
      year: 2018,
      month: 8,
      day: 29,
      isIntercalation: false
    )

    expect(
      input: solarDate,
      output: output,
      formattedString: "2018년 8월 29일(평달)",
      zodiac: "무술(戊戌)년 신유(辛酉)월 계유(癸酉)일"
    )
  }

  @Test
  func testSolarToLunar_2023_01_01() {
    var solarDate = Date()
    solarDate.year = 2023
    solarDate.month = 1
    solarDate.day = 1

    let output = LunarDate(
      year: 2022,
      month: 12,
      day: 10,
      isIntercalation: false
    )

    expect(
      input: solarDate,
      output: output,
      formattedString: "2022년 12월 10일(평달)",
      zodiac: "임인(壬寅)년 계축(癸丑)월 기미(己未)일"
    )
  }

  @Test
  func testSolarToLunar_2023_02_19() {
    var solarDate = Date()
    solarDate.year = 2023
    solarDate.month = 2
    solarDate.day = 19

    let output = LunarDate(
      year: 2023,
      month: 1,
      day: 29,
      isIntercalation: false
    )

    expect(
      input: solarDate,
      output: output,
      formattedString: "2023년 1월 29일(평달)",
      zodiac: "계묘(癸卯)년 갑인(甲寅)월 무신(戊申)일"
    )
  }

  @Test
  func testSolarToLunar_2023_03_21() {
    var solarDate = Date()
    solarDate.year = 2023
    solarDate.month = 3
    solarDate.day = 21

    let output = LunarDate(
      year: 2023,
      month: 2,
      day: 30,
      isIntercalation: false
    )

    expect(
      input: solarDate,
      output: output,
      formattedString: "2023년 2월 30일(평달)",
      zodiac: "계묘(癸卯)년 을묘(乙卯)월 무인(戊寅)일"
    )
  }
  
  func testSolarToLunar_2023_04_20() {
    var solarDate = Date()
    solarDate.year = 2023
    solarDate.month = 4
    solarDate.day = 20

    let output = LunarDate(
      year: 2023,
      month: 3,
      day: 1,
      isIntercalation: false
    )

    expect(
      input: solarDate,
      output: output,
      formattedString: "2023년 3월 1일(평달)",
      zodiac: "계묘(癸卯)년 병진(丙辰)월 무신(戊申)일"
    )
  }

  @Test
  func testSolarToLunar_2023_5_21() {
    var solarDate = Date()
    solarDate.year = 2023
    solarDate.month = 5
    solarDate.day = 21

    let output = LunarDate(
      year: 2023,
      month: 4,
      day: 2,
      isIntercalation: false
    )

    expect(
      input: solarDate,
      output: output,
      formattedString: "2023년 4월 2일(평달)",
      zodiac: "계묘(癸卯)년 정사(丁巳)월 기묘(己卯)일"
    )
  }

  @Test
  func testSolarToLunar_2024_01_20() {
    var solarDate = Date()
    solarDate.year = 2024
    solarDate.month = 1
    solarDate.day = 20

    let output = LunarDate(
      year: 2023,
      month: 12,
      day: 10,
      isIntercalation: false
    )

    expect(
      input: solarDate,
      output: output,
      formattedString: "2023년 12월 10일(평달)",
      zodiac: "계묘(癸卯)년 을축(乙丑)월 계미(癸未)일"
    )
  }

  @Test
  func testSolarToLunar_2017010() {
    var solarDate = Date()
    solarDate.year = 2017
    solarDate.month = 7
    solarDate.day = 10

    let output = LunarDate(
      year: 2017,
      month: 5,
      day: 17,
      isIntercalation: true
    )

    expect(
      input: solarDate,
      output: output,
      formattedString: "2017년 5월 17일(윤달)",
      zodiac: "정유(丁酉)년 병오(丙午)월 무술(戊戌)일"
    )
  }
}
