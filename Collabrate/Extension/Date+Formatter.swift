//
//  Date+Formatter.swift
//  Smarock
//
//  Created by Guowei Mo on 01/01/2019.
//  Copyright © 2019 Smarock. All rights reserved.
//

import Foundation

extension Date {
  func fullDisplayDate() -> String {
    let formatter = LocalDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd EEE HH:mm"
    return formatter.string(from: self)
  }
    
  func displayRefrenceDate() -> String {
    let isToday = Calendar.current.isDateInToday(self)
    let isYesterday = Calendar.current.isDateInYesterday(self)
    let isTomorrow = Calendar.current.isDateInTomorrow(self)
    let formatter = LocalDateFormatter()
    
    if isToday {
      formatter.dateFormat = "HH:mm"
      return DisplayString.General.Date.today + " " + formatter.string(from: self)
    }
    if isYesterday {
      formatter.dateFormat = "HH:mm"
      return DisplayString.General.Date.yesterday + " " + formatter.string(from: self)
    }
    
    if isTomorrow {
      formatter.dateFormat = "HH:mm"
      return DisplayString.General.Date.tomorrow + " " + formatter.string(from: self)
    }
    formatter.dateFormat = "MMM dd HH:mm"
    return formatter.string(from: self)
  }
  
  func displayTimeDiff() -> String {
    let delta = Int(Date().timeIntervalSince(self))
    if delta < 60 {
      return DisplayString.General.Date.justNow
    } else if delta < 3600 {
      let min = delta / 60
      return DisplayString.General.Date.minsAgo(with: min)
    } else if delta < 3600 * 24 {
      let hour = delta / 3600
      return DisplayString.General.Date.hoursAgo(with: hour)
    } else if delta < 3600 * 24 * 7 {
      let day = delta / (3600 * 24)
      return DisplayString.General.Date.daysAgo(with: day)
    } else {
      return displayDateAndTime()
    }
  }
  
  func displaySlotTime(with duration: TimeInterval = 2400) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    let fromHourString = formatter.string(from: self)
    let toHourString = formatter.string(from: addingTimeInterval(duration))
    let slotString = "\(fromHourString)-\(toHourString)"
    return slotString
  }
  
  func displayDateAndTime() -> String {
    let formatter = LocalDateFormatter()
    formatter.dateFormat = "MMM dd HH:mm"
    return formatter.string(from: self)
  }

  func displayTime() -> String {
    let formatter = LocalDateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: self)
  }
  
  func displayDayAndDate() -> String {
    let formatter = LocalDateFormatter()
    formatter.dateFormat = "EEE MMM dd"
    return formatter.string(from: self)
  }
  
  var isToday: Bool {
    return Calendar.current.isDateInToday(self)
  }
}

class LocalDateFormatter: DateFormatter {
  override init() {
    super.init()
    timeZone = TimeZone.current
    locale = Locale.current
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TimeInterval {
  func toDisplayTime() -> String {
    let intTime = Int(self)
    let hour = intTime / 3600
    let min = (intTime % 3600) / 60
    let sec = intTime % 60
    let fhour = hour < 10 ? "0\(hour)" : "\(hour)"
    let fmin = min < 10 ? "0\(min)" : "\(min)"
    let fsec = sec < 10 ? "0\(sec)" : "\(sec)"
    let formmated = hour == 0 ? "\(fmin):\(fsec)" : "\(fhour):\(fmin):\(fsec)"
    return formmated
  }
  
  static let oneDay: TimeInterval = 24 * 3600
  static let oneHour: TimeInterval = 3600
}

extension Date {
  
  static func - (lhs: Date, rhs: Date) -> TimeInterval {
    return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
  }
}

extension Date {
  
  static var today: Date {
    return Date()
  }
  
  func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.Next,
               weekday,
               considerToday: considerToday)
  }
  
  func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.Previous,
               weekday,
               considerToday: considerToday)
  }
  
  func get(_ direction: SearchDirection,
           _ weekDay: Weekday,
           considerToday consider: Bool = false) -> Date {
    
    let dayName = weekDay.rawValue
    
    let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
    
    assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
    
    let searchWeekdayIndex = weekdaysName.index(of: dayName)! + 1
    
    let calendar = Calendar(identifier: .gregorian)
    
    if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
      return self
    }
    
    var nextDateComponent = DateComponents()
    nextDateComponent.weekday = searchWeekdayIndex
    
    
    let date = calendar.nextDate(after: self,
                                 matching: nextDateComponent,
                                 matchingPolicy: .nextTime,
                                 direction: direction.calendarSearchDirection)
    
    return date!
  }
  
}

// MARK: Helper methods
extension Date {
  func getWeekDaysInEnglish() -> [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    return calendar.weekdaySymbols
  }
  
  enum Weekday: String {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
  }
  
  enum SearchDirection {
    case Next
    case Previous
    
    var calendarSearchDirection: Calendar.SearchDirection {
      switch self {
      case .Next:
        return .forward
      case .Previous:
        return .backward
      }
    }
  }
}
