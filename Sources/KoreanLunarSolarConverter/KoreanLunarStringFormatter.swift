//
//  KoreanLunarStringFormatter.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

public final class KoreanLunarStringFormatter {
  private let koreanCheongan = ["갑", "을", "병", "정", "무", "기", "경", "신", "임", "계"]
  private let koreanGanji = ["자", "축", "인", "묘", "진", "사", "오", "미", "신", "유", "술", "해"]
  
  private let chineseCheongan = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
  private let chineseGanji = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
  
  private let dataSource = KoreanLunarDataSource()
  private let algorithm = KoreanLunarAlgorithm()
  private let converter = KoreanSolarToLunarConverter()
  
  public init() {
    
  }
  
  public func lunarDateString(fromSolar date: Date) -> String? {
    guard let lunarDate = try? converter.lunarDate(fromSolar: date)
    else { return nil }
    
    let string = "\(lunarDate.date.year)년 \(lunarDate.date.month)월 \(lunarDate.date.day)일"
    return lunarDate.isIntercalation ? string + "(윤달)" : string + "(평달)"
  }
  
  public func lunarZodiac(fromSolar date: Date) -> String? {
    guard let lunarDate = try? converter.lunarDate(fromSolar: date)
    else { return nil }
    
    let yearFirstIndex = gapjaYearFirstIndex(from: lunarDate.date)
    let yearLastIndex = gapjaYearLastIndex(from: lunarDate.date)
    
    let monthFirstIndex = gapjaMonthFirstIndex(from: lunarDate.date)
    let monthLastIndex = gapjaMonthLastIndex(from: lunarDate.date)
    
    let dayFirstIndex = gapjaDayFirstIndex(from: lunarDate.date)
    let dayLastIndex = gapjaDayLastIndex(from: lunarDate.date)
    
    let yearKR = yearKR(at: (first: yearFirstIndex, last: yearLastIndex))
    let yearCH = yearCH(at: (first: yearFirstIndex, last: yearLastIndex))
    let monthKR = monthKR(at: (first: monthFirstIndex, last: monthLastIndex))
    let monthCH = monthCH(at: (first: monthFirstIndex, last: monthLastIndex))
    let dayKR = dayKR(at: (first: dayFirstIndex, last: dayLastIndex))
    let dayCH = dayCH(at: (first: dayFirstIndex, last: dayLastIndex))
    return "\(yearKR)(\(yearCH))년 \(monthKR)(\(monthCH))월 \(dayKR)(\(dayCH))일"
  }

  public func lunarZodiac(fromLunar date: Date) -> String {
    let yearFirstIndex = gapjaYearFirstIndex(from: date)
    let yearLastIndex = gapjaYearLastIndex(from: date)
    
    let monthFirstIndex = gapjaMonthFirstIndex(from: date)
    let monthLastIndex = gapjaMonthLastIndex(from: date)
    
    let dayFirstIndex = gapjaDayFirstIndex(from: date)
    let dayLastIndex = gapjaDayLastIndex(from: date)
    
    let yearKR = yearKR(at: (first: yearFirstIndex, last: yearLastIndex))
    let yearCH = yearCH(at: (first: yearFirstIndex, last: yearLastIndex))
    let monthKR = monthKR(at: (first: monthFirstIndex, last: monthLastIndex))
    let monthCH = monthCH(at: (first: monthFirstIndex, last: monthLastIndex))
    let dayKR = dayKR(at: (first: dayFirstIndex, last: dayLastIndex))
    let dayCH = dayCH(at: (first: dayFirstIndex, last: dayLastIndex))
    return "\(yearKR)(\(yearCH))년 \(monthKR)(\(monthCH))월 \(dayKR)(\(dayCH))일"
  }
}

extension KoreanLunarStringFormatter {
  private func gapjaYearFirstIndex(from date: Date) -> Int {
    return ((date.year + 6) - dataSource.lunarBaseYear) % koreanCheongan.count
  }
  
  private func gapjaYearLastIndex(from date: Date) -> Int {
    return ((date.year + 0) - dataSource.lunarBaseYear) % koreanGanji.count
  }
  
  private func gapjaMonthFirstIndex(from date: Date) -> Int {
    var monthCount = date.month
    monthCount += 12 * (date.year - dataSource.lunarBaseYear)
    return (monthCount + 3) % koreanCheongan.count
  }
  
  private func gapjaMonthLastIndex(from date: Date) -> Int {
    var monthCount = date.month
    monthCount += 12 * (date.year - dataSource.lunarBaseYear)
    return (monthCount + 1) % koreanGanji.count
  }
  
  private func gapjaDayFirstIndex(from date: Date) -> Int {
    let absDays = algorithm.lunarAbsDays(year: date.year,
                                         month: date.month,
                                         day: date.day,
                                         isIntercalation: true)
    
    guard absDays > 0 else { return 0 }
    
    return (absDays + 4) % koreanCheongan.count
  }
  
  private func gapjaDayLastIndex(from date: Date) -> Int {
    let absDays = algorithm.lunarAbsDays(year: date.year,
                                         month: date.month,
                                         day: date.day,
                                         isIntercalation: true)
    
    guard absDays > 0 else { return 0 }
    
    return (absDays + 2) % koreanGanji.count
  }
  
  private func yearKR(at indexes: (first: Int, last: Int)) -> String {
    "\(koreanCheongan[indexes.first])\(koreanGanji[indexes.last])"
  }
  
  private func yearCH(at indexes: (first: Int, last: Int)) -> String {
    "\(chineseCheongan[indexes.first])\(chineseGanji[indexes.last])"
  }
  
  private func monthKR(at indexes: (first: Int, last: Int)) -> String {
    "\(koreanCheongan[indexes.first])\(koreanGanji[indexes.last])"
  }
  
  private func monthCH(at indexes: (first: Int, last: Int)) -> String {
    "\(chineseCheongan[indexes.first])\(chineseGanji[indexes.last])"
  }
  
  private func dayKR(at indexes: (first: Int, last: Int)) -> String {
    "\(koreanCheongan[indexes.first])\(koreanGanji[indexes.last])"
  }
  
  private func dayCH(at indexes: (first: Int, last: Int)) -> String {
    "\(chineseCheongan[indexes.first])\(chineseGanji[indexes.last])"
  }
}
