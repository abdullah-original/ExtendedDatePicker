import Foundation
import SwiftUI

public enum DateMode {
  /// Hour. Assumes the provided date range is within the same day.
  case hour
  /// Date
  case date
  /// Date, hour and minute.
  case dateTime
  /// Week of year
  case week
  /// Month and year.
  case monthYear
  /// Year
  case year
  
  var asCalendarComponent: Calendar.Component {
    switch self {
    case .hour:
      return .hour
    case .dateTime:
      return .minute
    case .date:
      return .day
    case .monthYear:
      return .month
    case .year:
      return .year
    case .week:
      return .weekOfYear
    }
  }
  
  var asDatePickerComponents: DatePickerComponents {
    switch self {
    case .date:
      return [.date]
    case .dateTime:
      return [.date, .hourAndMinute]
    default:
      return []
    }
  }
}
