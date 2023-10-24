//
//  KoreanLunarStringFormatter.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

/// A class to format Korean lunar date strings.
public final class KoreanLunarStringFormatter {
  
  /// Enumeration for different zodiac types: year, month, day.
  private enum ZodiacType {
    case year, month, day
  }
  
  private let dataSource = KoreanLunarDataSource()
  private let algorithm = KoreanLunarAlgorithm()
  private let converter = KoreanSolarToLunarConverter()
  
  /// Initializes a new instance of KoreanLunarStringFormatter.
  public init() { }
  
  /// Returns a formatted lunar date string from a given solar date.
  /// - Parameter date: The solar date to be converted.
  /// - Throws: An error if the conversion fails.
  /// - Returns: A string representing the lunar date.
  public func lunarDateString(fromSolar date: Date) throws -> String {
    let lunarDate = try converter.lunarDate(fromSolar: date)
    return "\(lunarDate.date.year)년 \(lunarDate.date.month)월 \(lunarDate.date.day)일" +
    (lunarDate.isIntercalation ? "(윤달)" : "(평달)")
  }
  
  /// Returns a zodiac string from a given solar date.
  /// - Parameter date: The solar date to be converted.
  /// - Throws: An error if the conversion fails.
  /// - Returns: A string representing the lunar zodiac.
  public func lunarZodiac(fromSolar date: Date) throws -> String {
    let lunarDate = try converter.lunarDate(fromSolar: date)
    return constructZodiacString(from: lunarDate.date)
  }
  
  /// Returns a zodiac string from a given lunar date.
  /// - Parameter date: The lunar date.
  /// - Returns: A string representing the lunar zodiac.
  public func lunarZodiac(fromLunar date: Date) -> String {
    return constructZodiacString(from: date)
  }
  
  /// Constructs a zodiac string from a given date.
  /// - Parameter date: The date to be used.
  /// - Returns: A string representing the zodiac.
  private func constructZodiacString(from date: Date) -> String {
    let year = zodiac(from: date, type: .year)
    let month = zodiac(from: date, type: .month)
    let day = zodiac(from: date, type: .day)
    return "\(year.KR)(\(year.CH))년 \(month.KR)(\(month.CH))월 \(day.KR)(\(day.CH))일"
  }
  
  /// Returns the zodiac string for a given date and type.
  /// - Parameters:
  ///   - date: The date to be used.
  ///   - type: The type of zodiac (year, month, day).
  /// - Returns: A tuple containing Korean and Chinese zodiac strings.
  private func zodiac(from date: Date, type: ZodiacType) -> (KR: String, CH: String) {
    let (firstIndex, lastIndex) = zodiacIndexes(from: date, for: type)
    let zodiac = dataSource.zodiac
    return (KR: "\(zodiac.koreanTenStems[firstIndex])\(zodiac.koreanTwelveBranches[lastIndex])",
            CH: "\(zodiac.chineseTenStems[firstIndex])\(zodiac.chineseTwelveBranches[lastIndex])")
  }
}

extension KoreanLunarStringFormatter {
  /// Retrieves zodiac indexes for a given date and type.
  /// - Parameters:
  ///   - date: The date to be used.
  ///   - type: The type of zodiac (year, month, day).
  /// - Returns: A tuple containing the first and last index for ten stems and twelve branches.
  private func zodiacIndexes(from date: Date, for type: ZodiacType) -> (Int, Int) {
    switch type {
    case .year:
      return (yearTenStemsIndex(from: date), yearTwelveBranchesIndex(from: date))
    case .month:
      let monthCount = monthCount(from: date)
      return (monthTenStemsIndex(monthCount: monthCount), monthTwelveBranchesIndex(monthCount: monthCount))
    case .day:
      return (dayTenStemsIndex(from: date), dayTwelveBranchesIndex(from: date))
    }
  }
  
  /// Computes the month count based on a given date.
  /// - Parameter date: The date to be used.
  /// - Returns: An integer representing the month count.
  private func monthCount(from date: Date) -> Int {
    return date.month + 12 * (date.year - dataSource.lunarBaseYear)
  }
  
  /// Retrieves the ten stems index for a given year.
  /// - Parameter date: The date whose year is to be used.
  /// - Returns: An integer representing the ten stems index for the year.
  private func yearTenStemsIndex(from date: Date) -> Int {
    return (date.year + 6 - dataSource.lunarBaseYear) % dataSource.zodiac.koreanTenStems.count
  }
  
  /// Retrieves the twelve branches index for a given year.
  /// - Parameter date: The date whose year is to be used.
  /// - Returns: An integer representing the twelve branches index for the year.
  private func yearTwelveBranchesIndex(from date: Date) -> Int {
    return (date.year - dataSource.lunarBaseYear) % dataSource.zodiac.koreanTwelveBranches.count
  }
  
  /// Retrieves the ten stems index for a given month count.
  /// - Parameter monthCount: The month count to be used.
  /// - Returns: An integer representing the ten stems index for the month.
  private func monthTenStemsIndex(monthCount: Int) -> Int {
    return (monthCount + 3) % dataSource.zodiac.koreanTenStems.count
  }
  
  /// Retrieves the twelve branches index for a given month count.
  /// - Parameter monthCount: The month count to be used.
  /// - Returns: An integer representing the twelve branches index for the month.
  private func monthTwelveBranchesIndex(monthCount: Int) -> Int {
    return (monthCount + 1) % dataSource.zodiac.koreanTwelveBranches.count
  }
  
  /// Retrieves the ten stems index for a given day.
  /// - Parameter date: The date to be used.
  /// - Returns: An integer representing the ten stems index for the day.
  private func dayTenStemsIndex(from date: Date) -> Int {
    let absDays = getAbsDays(from: date)
    return (absDays + 4) % dataSource.zodiac.koreanTenStems.count
  }
  
  /// Retrieves the twelve branches index for a given day.
  /// - Parameter date: The date to be used.
  /// - Returns: An integer representing the twelve branches index for the day.
  private func dayTwelveBranchesIndex(from date: Date) -> Int {
    let absDays = getAbsDays(from: date)
    return (absDays + 2) % dataSource.zodiac.koreanTwelveBranches.count
  }
  
  /// Computes the absolute days for a given date.
  /// - Parameter date: The date to be used.
  /// - Returns: An integer representing the absolute days.
  private func getAbsDays(from date: Date) -> Int {
    return algorithm.lunarAbsDays(year: date.year,
                                  month: date.month,
                                  day: date.day,
                                  isIntercalation: true)
  }
}
