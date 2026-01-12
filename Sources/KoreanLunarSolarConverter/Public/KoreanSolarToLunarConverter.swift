//
//  KoreanSolarToLunarConverter.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

/// A converter class for transforming solar dates to lunar dates in Korean context.
public final class KoreanSolarToLunarConverter {
  private let dataSource: KoreanLunarDataSource
  private let solarDateRangeChecker = KoreanSolarDateRangeChecker()
  
  /// Initializes a new instance of the converter.
  public init() throws {
    dataSource = try KoreanLunarDataSource()
  }

  /// Transforms a given solar date into its corresponding lunar date.
  ///
  /// 음력 변환은 1000년 01월 01일 부터 2050년 11월 18일까지 지원
  /// 
  /// - Parameter solarDate: The solar date to be converted.
  /// - Returns: The corresponding Korean lunar date.
  /// - Throws: An error of type `KoreanLunarConvertError` if the solar date is not valid.
  public func lunarDate(fromSolar solarDate: Date) throws -> LunarDate {
    guard solarDateRangeChecker.isValidDate(solarDate: solarDate)
    else { throw KoreanLunarConvertError.invalidDate }

    let solarYear = solarDate.year
    let solarMonth = solarDate.month
    let solarDay = solarDate.day

    return try dataSource.fetchLunarBySolar(
      solYear: solarYear,
      solMonth: solarMonth,
      solDay: solarDay
    )
  }
}
