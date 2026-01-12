//
//  KoreanLunarStringFormatter.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

/// A class to format Korean lunar date strings.
public final class KoreanLunarStringFormatter {
  private let dataSource: KoreanLunarDataSource
  private let converter: KoreanSolarToLunarConverter

  /// Initializes a new instance of KoreanLunarStringFormatter.
  public init() throws {
    dataSource = try KoreanLunarDataSource()
    converter = try KoreanSolarToLunarConverter()
  }
  /// Returns a formatted lunar date string from a given solar date.
  /// - Parameter date: The solar date to be converted.
  /// - Throws: An error if the conversion fails.
  /// - Returns: A string representing the lunar date.
  public func lunarDateString(fromSolar date: Date) throws -> String {
    let lunarDates = try converter.lunarDate(fromSolar: date)
    return "\(lunarDates.year)년 \(lunarDates.month)월 \(lunarDates.day)일" +
    (lunarDates.isIntercalation ? "(윤달)" : "(평달)")
  }
  
  /// Returns a zodiac string from a given solar date.
  /// - Parameter date: The solar date to be converted.
  /// - Throws: An error if the conversion fails.
  /// - Returns: A string representing the lunar zodiac.
  public func lunarZodiac(fromSolar date: Date) throws -> String {
    return try dataSource.fetchZodiac(
      solYear: date.year,
      solMonth: date.month,
      solDay: date.day
    )
  }

  public func lunarZodiacs(fromLunar lunarDate: LunarDate) throws -> [String] {
    return try dataSource.fetchZodiac(
      lunYear: lunarDate.year,
      lunMonth: lunarDate.month,
      lunDay: lunarDate.day
    )
  }
}
