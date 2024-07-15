import Foundation

final class ExtendedDatePickerFormatter {
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
  }

  func format(from date: Date, mode: DateMode) -> String {
    if mode == .week, let endOfWeek = calendar.date(byAdding: .day, value: 6, to: date) {
      self.dateIntervalFormatter.timeStyle = .none
      self.dateIntervalFormatter.dateStyle = .medium
      return dateIntervalFormatter.string(from: date, to: endOfWeek)
    }

    if [.monthYear, .year].contains(mode) {
      dateFormatter.dateFormat = switch mode {
      case .monthYear:
        "MMMM yyyy"
      case .year:
        "yyyy"
      default:
        ""
      }

      return dateFormatter.string(from: date)
    }
    
    switch mode {
    case .hour:
      dateFormatter.timeStyle = .short
      dateFormatter.dateStyle = .none
    case .date:
      dateFormatter.timeStyle = .none
      dateFormatter.dateStyle = .long
    case .dateTime:
      dateFormatter.timeStyle = .short
      dateFormatter.dateStyle = .long
    default:
      dateFormatter.timeStyle = .none
      dateFormatter.dateStyle = .none
    }

    return dateFormatter.string(from: date)
  }
}
