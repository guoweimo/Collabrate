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
}
