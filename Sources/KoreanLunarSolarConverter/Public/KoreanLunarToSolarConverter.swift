//
//  KoreanLunarToSolarConverter.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

/// A class to convert Korean lunar dates to solar dates.
public final class KoreanLunarToSolarConverter {
  private let dataSource: KoreanLunarDataSource
  private let lunarDateRangeChecker = KoreanLunarDateRangeChecker()

  /// Default initializer.
  public init() throws {
    dataSource = try KoreanLunarDataSource()
  }

  /// Converts a lunar date to a solar date.
  ///
  /// 양력 변환은 2016년 01월 01일 부터 2036년 12월 31일까지 지원
  /// 그 해의 윤달 월과 같을 때 기본을 ‘평달()’로 간주합니다. 만약 윤달로 간주해야한다면 타 API 사용을 권장합니다.
  /// - Parameter lunarDate: The lunar date to convert.
  /// - Returns: A `Date` object containing the converted solar date.
  /// - Throws: An error if the conversion fails.
  public func solarDate(fromLunar lunarDate: Date) throws -> [Date] {
    guard
      lunarDateRangeChecker.isValidDate(lunarDate: lunarDate)
    else {
      throw KoreanLunarConvertError.invalidDate
    }

    let lunYear = lunarDate.year
    let lunMonth = lunarDate.month
    let lunDay = lunarDate.day

    return try dataSource.fetchSolarByLunar(
      lunYear: lunYear,
      lunMonth: lunMonth,
      lunDay: lunDay
    )
  }
}
