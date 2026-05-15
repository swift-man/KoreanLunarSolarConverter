# ``KoreanLunarSolarConverter``

Convert dates between the Gregorian calendar and the Korean lunar calendar.

## Overview

KoreanLunarSolarConverter provides offline date conversion based on Korean lunar calendar data.

The supported range is:

- Gregorian calendar: 2016-01-01 through 2036-12-31
- Korean lunar calendar: 2015-11-30 through 2036-11-29

## Convert Lunar Dates to Gregorian Dates

```swift
import KoreanLunarSolarConverter

let lunarDate = Date()
let converter = try KoreanLunarToSolarConverter()
let solarDates = try converter.solarDate(fromLunar: lunarDate)
```

## Convert Gregorian Dates to Lunar Dates

```swift
import KoreanLunarSolarConverter

let solarDate = Date()
let converter = try KoreanSolarToLunarConverter()
let lunarDate = try converter.lunarDate(fromSolar: solarDate)
```

## Format Korean Lunar Dates

```swift
import KoreanLunarSolarConverter

let formatter = KoreanLunarStringFormatter()
let lunarDateString = try formatter.lunarDateString(fromSolar: Date())
let lunarZodiac = try formatter.lunarZodiac(fromSolar: Date())
```

## Topics

### Conversion

- ``KoreanLunarToSolarConverter``
- ``KoreanSolarToLunarConverter``
- ``LunarDate``

### Formatting

- ``KoreanLunarStringFormatter``

### Errors

- ``KoreanLunarConvertError``
