//
//  KoreanIntercalationCheckerTests.swift
//  KoreanLunarSolarConverter
//
//  Created by NHN on 1/6/25.
//

import XCTest
import KoreanLunarSolarConverter

final class KoreanIntercalationCheckerTests: XCTestCase {
  func testIntercalation_2022() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2022)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2023() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2023)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2024() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2024)
      XCTAssertTrue(hasIntercalation)
  }

  func testIntercalation_2025() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2025)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2026() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2026)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2027() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2027)
      XCTAssertTrue(hasIntercalation)
  }

  func testIntercalation_2028() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2028)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2029() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2029)
      XCTAssertTrue(hasIntercalation)
  }

  func testIntercalation_2030() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2030)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2031() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2031)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2032() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2032)
      XCTAssertTrue(hasIntercalation)
  }

  func testIntercalation_2033() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2033)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2034() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2034)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2035() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2035)
      XCTAssertTrue(hasIntercalation)
  }

  func testIntercalation_2036() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2036)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2037() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2037)
      XCTAssertTrue(hasIntercalation)
  }

  func testIntercalation_2038() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2038)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2039() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2039)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2040() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2040)
      XCTAssertTrue(hasIntercalation)
  }

  func testIntercalation_2041() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2041)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2042() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2042)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2043() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2043)
      XCTAssertTrue(hasIntercalation)
  }

  func testIntercalation_2044() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2044)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2045() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2045)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2046() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2046)
      XCTAssertTrue(hasIntercalation)
  }

  func testIntercalation_2047() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2047)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2048() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2048)
      XCTAssertTrue(hasIntercalation)
  }

  func testIntercalation_2049() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2049)
      XCTAssertFalse(hasIntercalation)
  }

  func testIntercalation_2050() {
      let hasIntercalation = KoreanIntercalationChecker.hasIntercalation(in: 2050)
      XCTAssertFalse(hasIntercalation)
  }
}
