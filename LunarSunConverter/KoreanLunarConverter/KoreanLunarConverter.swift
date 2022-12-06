//
//  KoreanLunarConverter.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/06.
//

import Foundation

public final class KoreanLunarConverter {
  enum CalendarType {
    case lunar
    case solar
  }
  
  enum LimiteDate: Int {
    case lunarMin = 10000101
    case lunarMax = 20501118
    case solarMin = 10000213
    case solarMax = 20501231
    
    static func min(calendarType: CalendarType) -> LimiteDate {
      calendarType == .lunar ? .lunarMin : .solarMin
    }
    
    static func max(calendarType: CalendarType) -> LimiteDate {
      calendarType == .lunar ? .lunarMax : .solarMax
    }
  }
  
  private let dataSource = KoreanLunarDataSource()

  private let solarDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 29]
  private let koreanCheongan = ["갑", "을", "병", "정", "무", "기", "경", "신", "임", "계"]
  private let koreanGanji = ["자", "축", "인", "묘", "진", "사", "오", "미", "신", "유", "술", "해"]
  private let koreanGapjaUnit = ["년", "월", "일"]

  private let chineseCheongan = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
  private let chineseGanji = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]

  private var lunarYear = 0
  private var lunarMonth = 0
  private var lunarDay = 0
  private var isIntercalation = false

  private var solarYear = 0
  private var solarMonth = 0
  private var solarDay = 0

  private var gapjaYearInx = [0, 0, 0]
  private var gapjaMonthInx = [0, 0, 1]
  private var gapjaDayInx = [0, 0, 2]

  public var lunarDate: Date {
    var result = Date()
    result.year = lunarYear
    result.month = lunarMonth
    result.day = lunarDay
    return result
  }

  public var solarDate: Date {
    var result = Date()
    result.year = solarYear
    result.month = solarMonth
    result.day = solarDay
    return result
  }

   

  private func lunarDays(year: Int,
                         month: Int? = nil,
                         isIntercalation: Bool? = nil) -> Int {
    let lunar = dataSource.lunar(year: year)

    guard
      let month,
      let isIntercalation
    else { return (lunar >> 17) & 0x01FF }

    if isIntercalation && dataSource.lunarIntercalationMonth(lunar: lunar) == month {
      return ((lunar >> 16) & 0x01) > 0 ? dataSource.lunarBigMonthDay : dataSource.lunarSmallMonthDay
    }
    return ((lunar >> (12 - month)) & 0x01) > 0 ? dataSource.lunarBigMonthDay : dataSource.lunarSmallMonthDay
  }

  private func lunarDaysBeforeBaseYear(year: Int) -> Int {
    var days = 0
    for baseYear in dataSource.lunarBaseYear ... year {
      days += lunarDays(year: baseYear)
    }
    return days
  }

  private func lunarDaysBeforeBaseMonth(year: Int, month: Int, isIntercalation: Bool) -> Int {
    var days = 0
    if year >= dataSource.lunarBaseYear && month > 0 {
      for baseMonth in 1 ... month {
        days += lunarDays(year: year, month: baseMonth, isIntercalation: false)
      }
    }

    var intercalationMonth = 0
    if isIntercalation {
      intercalationMonth = dataSource.lunarIntercalationMonth(lunar: dataSource.lunar(year: year))
    }
    if intercalationMonth > 0 && intercalationMonth < month + 1 {
      days += lunarDays(year: year, month: intercalationMonth, isIntercalation: true)
    }
    return days
  }

  private func lunarAbsDays(year: Int,
                            month: Int,
                            day: Int,
                            isIntercalation: Bool) -> Int {
    var days = lunarDaysBeforeBaseYear(year: year - 1) + lunarDaysBeforeBaseMonth(year: year,
                                                                                  month: month - 1,
                                                                                  isIntercalation: true) + day
    if isIntercalation && dataSource.lunarIntercalationMonth(lunar: dataSource.lunar(year: year)) == month {
      days += lunarDays(year: year, month: month, isIntercalation: false)
    }
    return days
  }

  private func isSolarIntercalationYear(lunar: Int) -> Bool {
    return (lunar >> 30) & 0x01 > 0
  }

  private func solarDays(year: Int, month: Int? = nil) -> Int {
    let lunar = dataSource.lunar(year: year)
    if let month {
      return month == 2 && isSolarIntercalationYear(lunar: lunar) ? solarDays[12] : solarDays[month - 1]
    }

    return isSolarIntercalationYear(lunar: lunar) ? dataSource.solarBigYearDay : dataSource.solarSmallYearDay
  }

  private func solarDaysBeforeBaseYear(year: Int) -> Int {
    var days = 0
    for baseYear in dataSource.lunarBaseYear ..< year + 1 {
      days += solarDays(year: baseYear)
    }
    return days
  }

  private func solarDaysBeforeBaseMonth(year: Int, month: Int) -> Int {
    var days = 0
    for baseMonth in 1 ..< month + 1 {
      days += solarDays(year: year, month: baseMonth)
    }
    return days
  }

  private func solarAbsDays(year: Int,
                            month: Int,
                            day: Int) -> Int {
    var days = solarDaysBeforeBaseYear(year: year-1) + solarDaysBeforeBaseMonth(year: year, month: month-1) + day
    days -= dataSource.solarLunarDayDiff
    return days
  }

  private func solarDateByLunarDate(lunarYear: Int,
                                    lunarMonth: Int,
                                    lunarDay: Int,
                                    isIntercalation: Bool) {
    let absDays = lunarAbsDays(year: lunarYear, month: lunarMonth, day: lunarDay, isIntercalation: isIntercalation)
    var solarYear = 0
    var solarMonth = 0
    var solarDay = 0

    solarYear = absDays < solarAbsDays(year: lunarYear+1, month: 1, day: 1) ? lunarYear : lunarYear+1

    for month in stride(from: 12, through: 1, by: -1) {
      let absDaysByMonth = solarAbsDays(year: solarYear, month: month, day: 1)
      if absDays >= absDaysByMonth {
        solarMonth = month
        solarDay = absDays - absDaysByMonth + 1
        break
      }
    }

    self.solarYear = solarYear
    self.solarMonth = solarMonth
    self.solarDay = solarDay
  }

  private func lunarDateBySolarDate(solarYear: Int,
                                    solarMonth: Int,
                                    solarDay: Int) {
    let absDays = solarAbsDays(year: solarYear, month: solarMonth, day: solarDay)
    let lunarYear = absDays >= lunarAbsDays(year: solarYear,
                                            month: 1,
                                            day: 1,
                                            isIntercalation: false) ? solarYear : solarYear - 1
    var lunarMonth = 0
    var lunarDay = 0
    var isIntercalation = false

    for month in stride(from: 12, through: 1, by: -1) {
      let absDaysByMonth = lunarAbsDays(year: lunarYear,
                                        month: month,
                                        day: 1,
                                        isIntercalation: false)
      if absDays >= absDaysByMonth {
        lunarMonth = month
        if dataSource.lunarIntercalationMonth(lunar: dataSource.lunar(year: lunarYear)) == month {
          isIntercalation = absDays >= lunarAbsDays(year: lunarYear,
                                                    month: month,
                                                    day: 1,
                                                    isIntercalation: true)
        }

        lunarDay = absDays - lunarAbsDays(year: lunarYear,
                                          month: lunarMonth,
                                          day: 1,
                                          isIntercalation: isIntercalation) + 1
        break
      }
    }

    self.lunarYear = lunarYear
    self.lunarMonth = lunarMonth
    self.lunarDay = lunarDay
    self.isIntercalation = isIntercalation
  }

  private func isValidDate(type: CalendarType,
                           isIntercalation: Bool,
                           year: Int,
                           month: Int,
                           day: Int) -> Bool {
    let dateValue = year*10000 + month*100 + day
    /// 1582. 10. 5 ~ 1582. 10. 14 is not valid
    
    let minValue = LimiteDate.min(calendarType: type).rawValue
    let maxValue = LimiteDate.max(calendarType: type).rawValue

    if minValue <= dateValue && maxValue >= dateValue {
      if month > 0 && month < 13 && day > 0 {
        var dayLimit: Int

        if type == .lunar {
          dayLimit = lunarDays(year: year,
                               month: month,
                               isIntercalation: isIntercalation)
        } else {
          dayLimit = solarDays(year: year, month: month)
        }

        if type == .solar && year == 1582 && month == 10 {
          if day > 4 && day < 15 {
            return false
          } else {
            dayLimit += 10
          }
        }

        if day <= dayLimit {
          return true
        }
      }
    }

    return false
  }

  public func lunarDate(lunarYear: Int,
                        lunarMonth: Int,
                        lunarDay: Int,
                        isIntercalation: Bool) -> Bool {

    guard isValidDate(type: .lunar,
                      isIntercalation: isIntercalation,
                      year: lunarYear,
                      month: lunarMonth,
                      day: lunarDay)
    else { return false }

    self.lunarYear = lunarYear
    self.lunarMonth = lunarMonth
    self.lunarDay = lunarDay

    self.isIntercalation = isIntercalation && dataSource.lunarIntercalationMonth(lunar: dataSource.lunar(year: lunarYear)) == lunarMonth
    solarDateByLunarDate(lunarYear: lunarYear,
                         lunarMonth: lunarMonth,
                         lunarDay: lunarDay,
                         isIntercalation: isIntercalation)

    return true
  }

  public func solarDate(solarYear: Int,
                        solarMonth: Int,
                        solarDay: Int) -> Bool {
    guard isValidDate(type: .solar,
                      isIntercalation: false,
                      year: solarYear,
                      month: solarMonth,
                      day: solarDay)
    else { return false }

    self.solarYear = solarYear
    self.solarMonth = solarMonth
    self.solarDay = solarDay
    lunarDateBySolarDate(solarYear: solarYear,
                         solarMonth: solarMonth,
                         solarDay: solarDay)

    return true
  }

  private func setupGapJa() {
    let absDays = lunarAbsDays(year: lunarYear,
                               month: lunarMonth,
                               day: lunarDay,
                               isIntercalation: isIntercalation)
    guard absDays > 0 else { return }
    
    self.gapjaYearInx[0] = ((lunarYear + 6) - dataSource.lunarBaseYear) % koreanCheongan.count
    self.gapjaYearInx[1] = ((lunarYear + 0) - dataSource.lunarBaseYear) % koreanGanji.count
    
    var monthCount = lunarMonth
    monthCount += 12 * (lunarYear - dataSource.lunarBaseYear)
    self.gapjaMonthInx[0] = (monthCount + 3) % koreanCheongan.count
    self.gapjaMonthInx[1] = (monthCount + 1) % koreanGanji.count
    
    self.gapjaDayInx[0] = (absDays + 4) % koreanCheongan.count
    self.gapjaDayInx[1] = (absDays + 2) % koreanGanji.count
  }
  
  public var lunarDateString: String {
    let result = "\(lunarYear)년 \(lunarMonth)월 \(lunarDay)일"
    return isIntercalation ? result + "(윤달)" : result
  }

  public var lunarZodiac: String {
    var first: String {
      "\(koreanCheongan[gapjaYearInx[0]])\(koreanGanji[gapjaYearInx[1]])(\(chineseCheongan[gapjaYearInx[0]])\( chineseGanji[gapjaYearInx[1]]))\(koreanGapjaUnit[gapjaYearInx[2]])"
    }

    var second: String {
      "\(koreanCheongan[gapjaMonthInx[0]])\(koreanGanji[gapjaMonthInx[1]])(\(chineseCheongan[gapjaMonthInx[0]])\(chineseGanji[gapjaMonthInx[1]]))\(koreanGapjaUnit[gapjaMonthInx[2]])"
    }

    var third: String {
      "\(koreanCheongan[gapjaDayInx[0]])\(koreanGanji[gapjaDayInx[1]])(\(chineseCheongan[gapjaDayInx[0]])\(chineseGanji[gapjaDayInx[1]]))\(koreanGapjaUnit[gapjaDayInx[2]])"
    }
    setupGapJa()
    
    return "\(first) \(second) \(third)"
  }
}
