import Foundation

public class ExtendedDatePickerFormatter {
  private let dateFormatter: DateFormatter
  private let dateIntervalFormatter: DateIntervalFormatter
  private let calendar: Calendar
  
  init(
    dateFormatter: DateFormatter = .init(), 
    dateIntervalFormatter: DateIntervalFormatter = .init(),
    calendar: Calendar = .current
  ) {
    self.calendar = calendar
    
    self.dateFormatter = dateFormatter
    self.dateFormatter.calendar = calendar
    self.dateFormatter.timeZone = calendar.timeZone
    self.dateFormatter.locale = calendar.locale

    self.dateIntervalFormatter = dateIntervalFormatter
    self.dateIntervalFormatter.calendar = calendar
    self.dateIntervalFormatter.locale = calendar.locale
    self.dateIntervalFormatter.timeZone = calendar.timeZone
    self.dateIntervalFormatter.timeStyle = .none
    self.dateIntervalFormatter.dateStyle = .medium
  }
  
  func format(from date: Date, mode: DateMode) -> String {
    dateFormatter.dateFormat = switch mode {
    case .hour:
      "HH:mm"
    case .date:
      "d MMMM yyyy"
    case .dateTime:
      "d MMMM yyyy, HH:mm"
    case .monthYear:
      "MMMM yyyy"
    case .year:
      "yyyy"
    case .week:
      ""
    }
    
    if mode == .week, let endOfWeek = calendar.date(byAdding: .day, value: 6, to: date) {
      return dateIntervalFormatter.string(from: date, to: endOfWeek)
    }

    return dateFormatter.string(from: date)
  }
}
