//
//  KoreanIntercalationChecker.swift
//  KoreanLunarSolarConverter
//
//  Created by NHN on 1/6/25.
//

public final class KoreanIntercalationChecker {
  /// Determines whether a given year contains an intercalation (leap month).
  ///
  /// 윤달 여부는 19년 주기 규칙에 따라 계산됩니다.
  /// - Parameter year: The year to check for an intercalation.
  /// - Returns: `true` if the year contains an intercalation; otherwise, `false`.
  ///
  /// 윤달은 19년 주기에서 특정 연도에 발생하며, 4년을 기준으로 시작하여
  /// [0, 3, 6, 9, 11, 14, 17] 번째 해에 윤달이 포함됩니다.
  public static func hasIntercalation(in year: Int) -> Bool {
    // 윤달 연도를 19년 주기로 확인
    let cycleYear = (year - 4) % 19 // 4년은 주기 시작점(서기 1900년 기준)
    let intercalationYears = [0, 3, 6, 9, 11, 14, 17] // 윤달이 포함된 연도들

    return intercalationYears.contains(cycleYear)
  }
}
