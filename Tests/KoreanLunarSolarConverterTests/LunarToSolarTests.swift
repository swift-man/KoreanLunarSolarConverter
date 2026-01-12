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
  func testLunarToSolar_2014_06_24() {
    var lunarDate = Date()
    lunarDate.year = 2014
    lunarDate.month = 6
    lunarDate.day = 24

    var target = Date()
    target.year = 2014
    target.month = 7
    target.day = 20

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
}
