//
//  KoreanLunarToSolarConverter.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

/// A class to convert Korean lunar dates to solar dates.
public final class KoreanLunarToSolarConverter {
  private let dataSource = KoreanLunarDataSource()
  private let lunarAlgorithm = KoreanLunarAlgorithm()
  private let solarAlgorithm = KoreanSolarAlgorithm()
  private let lunarDateRangeChecker = KoreanLunarDateRangeChecker()

  /// Default initializer.
  public init() {}

  /// Converts a lunar date to a solar date.
  ///
  /// 양력 변환은 1000년 02월 13일 부터 2050년 12월 31일까지 지원
  /// 그 해의 윤달 월과 같을 때 기본을 ‘평달()’로 간주합니다. 만약 윤달로 간주해야한다면 타 API 사용을 권장합니다.
  /// - Parameter lunarDate: The lunar date to convert.
  /// - Returns: A `KoreanDate` object containing the converted solar date.
  /// - Throws: An error if the conversion fails.
  public func solarDate(fromLunar lunarDate: Date) throws -> KoreanDate {
    guard
      lunarDateRangeChecker.isValidDate(lunarDate: lunarDate)
    else {
      throw KoreanLunarConvertError.invalidDate
    }

    let leapMonth = dataSource.lunarIntercalationMonth(year: lunarDate.year)

    if lunarDate.month == leapMonth {
      let normal = try solarDate(fromLunarDate: lunarDate, isIntercalation: false)
      return KoreanDate(date: normal, isIntercalation: false)
    } else {
      let date = try solarDate(fromLunarDate: lunarDate, isIntercalation: false)
      return KoreanDate(date: date, isIntercalation: false)
    }
  }
}

extension KoreanLunarToSolarConverter {
  /// Returns a solar date based on a given lunar date and intercalation status.
  /// - Parameters:
  ///   - date: The lunar date to convert.
  ///   - isIntercalation: Indicates whether the date is intercalary.
  /// - Returns: The converted solar date.
  /// - Throws: An error if the conversion fails.
  private func solarDate(fromLunarDate date: Date, isIntercalation: Bool) throws -> Date {
    let absDays = lunarAlgorithm.lunarAbsDays(year: date.year,
                                              month: date.month,
                                              day: date.day,
                                              isIntercalation: isIntercalation)

    let solarYear = calculateSolarYear(fromLunarYear: date.year, absDays: absDays)
    let (solarMonth, solarDay) = calculateSolarMonthAndDay(solarYear: solarYear, absDays: absDays)

    guard
      !isRemovedDateInGregorian(solarYear: solarYear,
                                solarMonth: solarMonth,
                                solarDay: solarDay)
    else {
      throw KoreanLunarConvertError.removedGregorianDate
    }

    var solarDate = Date()
    solarDate.year = solarYear
    solarDate.month = solarMonth
    solarDate.day = solarDay

    return solarDate
  }

  /// Calculates the solar year based on a given lunar year and absolute days.
  /// - Parameters:
  ///   - lunarYear: The lunar year to use for the calculation.
  ///   - absDays: The absolute days to use for the calculation.
  /// - Returns: The calculated solar year.
  private func calculateSolarYear(fromLunarYear lunarYear: Int, absDays: Int) -> Int {
    if absDays < solarAlgorithm.solarAbsDays(year: lunarYear + 1,
                                             month: 1,
                                             day: 1) {
      return lunarYear
    }
    return lunarYear + 1
  }

  /// Calculates the solar month and day based on a given solar year and absolute days.
  /// - Parameters:
  ///   - solarYear: The solar year to use for the calculation.
  ///   - absDays: The absolute days to use for the calculation.
  /// - Returns: A tuple containing the calculated solar month and day.
  private func calculateSolarMonthAndDay(solarYear: Int, absDays: Int) -> (Int, Int) {
    for month in stride(from: 12, through: 1, by: -1) {
      let absDaysByMonth = solarAlgorithm.solarAbsDays(year: solarYear,
                                                       month: month,
                                                       day: 1)
      if absDays >= absDaysByMonth {
        return (month, absDays - absDaysByMonth + 1)
      }
    }
    return (0, 0)
  }

  /// Checks if a given solar year, month, and day corresponds to a date removed in the Gregorian calendar.
  /// - Parameters:
  ///   - solarYear: The solar year to check.
  ///   - solarMonth: The solar month to check.
  ///   - solarDay: The solar day to check.
  /// - Returns: `true` if the date was removed in the Gregorian calendar, `false` otherwise.
  private func isRemovedDateInGregorian(solarYear: Int,
                                        solarMonth: Int,
                                        solarDay: Int) -> Bool {
    let gregorianTransitionYear = 1582
    let gregorianTransitionMonth = 10
    return solarYear == gregorianTransitionYear && solarMonth == gregorianTransitionMonth && solarDay > 4 && solarDay < 15
  }
}
