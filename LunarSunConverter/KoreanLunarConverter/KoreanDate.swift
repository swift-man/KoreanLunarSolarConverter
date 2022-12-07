//
//  KoreanDate.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

public struct KoreanDate {
  public let date: Date
  public let isIntercalation: Bool
  
  public init(date: Date, isIntercalation: Bool) {
    self.date = date
    self.isIntercalation = isIntercalation
  }
}
