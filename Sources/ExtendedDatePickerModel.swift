import Foundation
import SwiftUI

final class ExtendedDatePickerModel: ObservableObject {
  let dateRange: ClosedRange<Date>
  let mode: DateMode
  let calendar: Calendar
  private let dateFormatter: ExtendedDatePickerFormatter
  private var viewHasAppeared = false
  
  @Binding var selectedDate: Date
  @Published var customDatePickerRange: [Date: String] = [:]
  
  init(
    selectedDate: Binding<Date>,
    dateRange: ClosedRange<Date>,
    calendar: Calendar,
    mode: DateMode
  ) {
    self._selectedDate = selectedDate
    self.dateRange = dateRange
    self.calendar = calendar
    self.mode = mode
    self.dateFormatter = .init(calendar: calendar)
    
    if mode == .year {
      self.customDatePickerRange = yearOptions()
    } else if mode == .monthYear {
      self.customDatePickerRange = monthYearOptions()
    } else if mode == .week {
      self.customDatePickerRange = weekOptions()
    } else if mode == .hour {
      precondition(
        calendar.isDate(dateRange.lowerBound, inSameDayAs: dateRange.upperBound),
        "dateRange lowerBound and upperBound must be in the same day for .hour mode."
      )
      
      self.customDatePickerRange = hourOptions()
    }
  }

  func displayStyle(shouldUsePopover: Bool) -> DisplayStyle {
    switch (BuildTarget.current, shouldUsePopover) {
    case (.ios, true):
      return .popover
    case (.ios, false):
      return .overlay
    case (.mac, _), (.macCatalyst, false):
      if [.date, .dateTime].contains(mode) {
        return .nativeLabel
      } else {
        return .overlay
      }
    case (.macCatalyst, true):
      if #available(iOS 16.4, macCatalyst 16.4, *) {
        return .popover
      } else {
        return displayStyle(shouldUsePopover: false)
      }
    }
  }

  func viewDidAppear() {
    guard !viewHasAppeared else { return }
    if let first = customDatePickerRange.keys.sorted(by: <).first {
      selectedDate = first
    }
    
    viewHasAppeared = true
  }
  
  func formattedDate(for date: Date) -> String {
    dateFormatter.format(from: date, mode: mode)
  }
  
  func yearOptions() -> [Date: String] {
    var result = [Date: String]()
    (calendar.component(.year, from: dateRange.lowerBound)...calendar.component(.year, from: dateRange.upperBound)).forEach {
      let date = DateComponents(calendar: calendar, timeZone: calendar.timeZone, year: $0, month: 1, day: 1).date!
      result[date] = dateFormatter.format(from: date, mode: .year)
    }
    return result
  }
  
  func monthYearOptions() -> [Date: String] {
    
    var result = [Date: String]()
    var start = dateRange.lowerBound
    
    while calendar.compare(start, to: dateRange.upperBound, toGranularity: .month) != .orderedDescending {
      result[start] = dateFormatter.format(from: start, mode: .monthYear)
      start = getNext(component: .month, for: start, forward: true)
    }
    
    return result
  }
  
  func weekOptions() -> [Date: String] {
    var result = [Date: String]()
    
    let dateComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: dateRange.lowerBound)
    
    guard var startOfWeek = calendar.date(
      from: .init(
        weekOfYear: dateComponents.weekOfYear,
        yearForWeekOfYear: dateComponents.yearForWeekOfYear
      )
    ) else {
      return [:]
    }

    while calendar.compare(startOfWeek, to: dateRange.upperBound, toGranularity: .day) != .orderedDescending {
      result[startOfWeek] = dateFormatter.format(from: startOfWeek, mode: .week)
      startOfWeek = getNext(component: .weekOfYear, for: startOfWeek, forward: true)
    }
    
    return result
  }
  
  func hourOptions() -> [Date: String] {
    let lowerBound = calendar.component(.hour, from: dateRange.lowerBound)
    let upperBound = calendar.component(.hour, from: dateRange.upperBound)
        
    return (lowerBound...upperBound).reduce(into: [Date: String]()) {
      let date = DateComponents(
        calendar: calendar, 
        timeZone: calendar.timeZone,
        year: calendar.component(.year, from: dateRange.upperBound),
        month: calendar.component(.month, from: dateRange.upperBound),
        day: calendar.component(.day, from: dateRange.upperBound),
        hour: $1,
        minute: 0
      )
        .date!

      $0[date] = dateFormatter.format(
        from: date,
        mode: .hour
      )
    }
  }
  
  var isBackButtonEnabled: Bool { 
    calendar.compare(selectedDate, to: dateRange.lowerBound, toGranularity: mode.asCalendarComponent) == .orderedDescending
  }
  
  func didPressBack() {
    let newDate = getNext(component: mode.asCalendarComponent, for: selectedDate, forward: false)
    
    let comparison = calendar.compare(newDate, to: dateRange.lowerBound, toGranularity: mode.asCalendarComponent)
    
    if comparison != .orderedAscending {
      selectedDate = newDate
    }
  }
  
  var isForwardButtonEnabled: Bool {
    calendar.compare(selectedDate, to: dateRange.upperBound, toGranularity: mode.asCalendarComponent) == .orderedAscending
  }
  
  func didPressForward() {
    let newDate = getNext(component: mode.asCalendarComponent, for: selectedDate, forward: true)
    
    let comparison = calendar.compare(newDate, to: dateRange.upperBound, toGranularity: mode.asCalendarComponent)
    
    if comparison != .orderedDescending {
      selectedDate = newDate
    }
  }
  
}

// MARK: - Private

private extension ExtendedDatePickerModel {
  func getNext(component: Calendar.Component, for date: Date, forward: Bool) -> Date {
    guard
      let newDate = calendar.date(byAdding: component, value: forward ? 1 : -1, to: date)
    else {
      return date
    }

    return newDate
  }
}
