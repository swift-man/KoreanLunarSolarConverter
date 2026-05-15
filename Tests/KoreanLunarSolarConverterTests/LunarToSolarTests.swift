//
//  LunarToSolarTests.swift
//  KoreanLunarConverterTests
//
//  Created by SwiftMan on 2022/12/07.
//

import Testing
import Foundation
@testable import KoreanLunarSolarConverter

struct LunarToSolarTests {
  @Test
  func testLunarToSolar_2031_2_8() {
    var lunarDate = Date()
    lunarDate.year = 2031
    lunarDate.month = 2
    lunarDate.day = 8

    var target = Date()
    target.year = 2031
    target.month = 3
    target.day = 1

    expect(
      input: lunarDate,
      output: target
    )
  }

  private func expect(
    input: Date,
    output: Date
  ) {
    do {
      let converter = try KoreanLunarToSolarConverter()
      let convertedDate = try converter.solarDate(fromLunar: input)

      #expect(convertedDate.first! === output)
    } catch {
      Issue.record("변환 중 에러 발생: \(error)")
    }
  }

  @Test
  func testLunarToSolar_2024_06_24() {
    var lunarDate = Date()
    lunarDate.year = 2024
    lunarDate.month = 6
    lunarDate.day = 24

    var target = Date()
    target.year = 2024
    target.month = 7
    target.day = 29

    expect(
      input: lunarDate,
      output: target
    )
  }

  @Test
  func testLunarToSolar_2017_06_29() {
    var lunarDate = Date()
    lunarDate.year = 2017
    lunarDate.month = 6
    lunarDate.day = 29

    var target = Date()
    target.year = 2017
    target.month = 8
    target.day = 20

    expect(
      input: lunarDate,
      output: target
    )
  }

  @Test
  func testLunarToSolar_2029_05_28() {
    var lunarDate = Date()
    lunarDate.year = 2029
    lunarDate.month = 5
    lunarDate.day = 28

    var target = Date()
    target.year = 2029
    target.month = 7
    target.day = 9

    expect(
      input: lunarDate,
      output: target
    )
  }

  @Test
  func testLunarToSolar_2029_10_08() {
    var lunarDate = Date()
    lunarDate.year = 2029
    lunarDate.month = 10
    lunarDate.day = 8

    var target = Date()
    target.year = 2029
    target.month = 11
    target.day = 13

    expect(
      input: lunarDate,
      output: target
    )
  }

  @Test
  func testLunarToSolar_2020_04_08() {
    var lunarDate = Date()
    lunarDate.year = 2020
    lunarDate.month = 4
    lunarDate.day = 8

    var target = Date()
    target.year = 2020
    target.month = 4
    target.day = 30

    expect(
      input: lunarDate,
      output: target
    )
  }

  @Test
  func testLunarToSolar_2020_12_29() {
    var lunarDate = Date()
    lunarDate.year = 2020
    lunarDate.month = 12
    lunarDate.day = 29

    var target = Date()
    target.year = 2021
    target.month = 2
    target.day = 10

    expect(
      input: lunarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2020 윤년 - 설")
  func testSolarToLunar_2019_12_30() {
    var solarDate = Date()
    solarDate.year = 2019
    solarDate.month = 12
    solarDate.day = 30

    var target = Date()
    target.year = 2020
    target.month = 1
    target.day = 24

    expect(
      input: solarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2020 윤년 - 설")
  func testSolarToLunar_2020_01_1() {
    var solarDate = Date()
    solarDate.year = 2020
    solarDate.month = 1
    solarDate.day = 1

    var target = Date()
    target.year = 2020
    target.month = 1
    target.day = 25

    expect(
      input: solarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2020 윤년 - 설")
  func testSolarToLunar_2020_01_02() {
    var solarDate = Date()
    solarDate.year = 2020
    solarDate.month = 1
    solarDate.day = 2

    var target = Date()
    target.year = 2020
    target.month = 1
    target.day = 26

    expect(
      input: solarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2020 윤년 - 부처님 오신날")
  func testSolarToLunar_2020_04_08() {
    var solarDate = Date()
    solarDate.year = 2020
    solarDate.month = 4
    solarDate.day = 8

    var target = Date()
    target.year = 2020
    target.month = 4
    target.day = 30

    expect(
      input: solarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2020 윤년 - 추석")
  func testSolarToLunar_2020_08_14() {
    var solarDate = Date()
    solarDate.year = 2020
    solarDate.month = 8
    solarDate.day = 14

    var target = Date()
    target.year = 2020
    target.month = 9
    target.day = 30

    expect(
      input: solarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2020 윤년 - 추석")
  func testSolarToLunar_2020_08_15() {
    var solarDate = Date()
    solarDate.year = 2020
    solarDate.month = 8
    solarDate.day = 15

    var target = Date()
    target.year = 2020
    target.month = 10
    target.day = 1

    expect(
      input: solarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2020 윤년 - 추석")
  func testSolarToLunar_2020_08_16() {
    var solarDate = Date()
    solarDate.year = 2020
    solarDate.month = 8
    solarDate.day = 16

    var target = Date()
    target.year = 2020
    target.month = 10
    target.day = 2

    expect(
      input: solarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2021 평년 - 설")
  func testSolarToLunar_2020_12_29() {
    var solarDate = Date()
    solarDate.year = 2020
    solarDate.month = 12
    solarDate.day = 30

    var target = Date()
    target.year = 2021
    target.month = 2
    target.day = 11

    expect(
      input: solarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2021 평년 - 설")
  func testSolarToLunar_2021_01_01() {
    var solarDate = Date()
    solarDate.year = 2021
    solarDate.month = 1
    solarDate.day = 1

    var target = Date()
    target.year = 2021
    target.month = 2
    target.day = 12

    expect(
      input: solarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2021 평년 - 설")
  func testSolarToLunar_2021_01_02() {
    var solarDate = Date()
    solarDate.year = 2021
    solarDate.month = 1
    solarDate.day = 2

    var target = Date()
    target.year = 2021
    target.month = 2
    target.day = 13

    expect(
      input: solarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2021 평년 - 부처님 오신날")
  func testSolarToLunar_2021_04_08() {
    var solarDate = Date()
    solarDate.year = 2021
    solarDate.month = 4
    solarDate.day = 8

    var target = Date()
    target.year = 2021
    target.month = 5
    target.day = 19

    expect(
      input: solarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2021 평년 - 추석")
  func testSolarToLunar_2021_08_14() {
    var solarDate = Date()
    solarDate.year = 2021
    solarDate.month = 8
    solarDate.day = 14

    var target = Date()
    target.year = 2021
    target.month = 9
    target.day = 20

    expect(
      input: solarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2021 평년 - 추석")
  func testSolarToLunar_2021_08_15() {
    var solarDate = Date()
    solarDate.year = 2021
    solarDate.month = 8
    solarDate.day = 15

    var target = Date()
    target.year = 2021
    target.month = 9
    target.day = 21

    expect(
      input: solarDate,
      output: target
    )
  }

  @Test("공휴일 테스트 - 2021 평년 - 추석")
  func testSolarToLunar_2021_08_16() {
    var solarDate = Date()
    solarDate.year = 2021
    solarDate.month = 8
    solarDate.day = 16

    var target = Date()
    target.year = 2021
    target.month = 9
    target.day = 22

    expect(
      input: solarDate,
      output: target
    )
  }
}
