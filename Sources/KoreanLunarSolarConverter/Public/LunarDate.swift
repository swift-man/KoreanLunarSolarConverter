//
//  LunarDate.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

/// Represents a Korean date which might be an intercalation.
public struct LunarDate: Equatable {
  /// The actual date.
  public let year: Int
  public let month: Int
  public let day: Int
  /// Indicates if the date is an intercalation.
  public let isIntercalation: Bool
  
  /// Initializes a new LunarDate.
  /// - Parameters:
  ///   - year: The year to represent.
  ///   - month: The month to represent.
  ///   - day: The day to represent.
  ///   - isIntercalation: Indicates if the date is an intercalation.
  public init(
    year: Int,
    month: Int,
    day: Int,
    isIntercalation: Bool
  ) {
    self.year = year
    self.month = month
    self.day = day
    self.isIntercalation = isIntercalation
  }
}
