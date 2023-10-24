//
//  KoreanDate.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

/// Represents a Korean date which might be an intercalation.
public struct KoreanDate {
  /// The actual date.
  public let date: Date
  /// Indicates if the date is an intercalation.
  public let isIntercalation: Bool
  
  /// Initializes a new KoreanDate.
  /// - Parameters:
  ///   - date: The date to represent.
  ///   - isIntercalation: Indicates if the date is an intercalation.
  public init(date: Date, isIntercalation: Bool) {
    self.date = date
    self.isIntercalation = isIntercalation
  }
}
