@testable import ExtendedDatePicker
import XCTest

final class ExtendedDatePickerFormatterTests: XCTestCase {
  
  private var sut: ExtendedDatePickerFormatter!
  private var calendar: Calendar = .current
    
  func testHourMode_shouldOnlyDisplayHour() {
    // Arrange
    self.calendar.locale = .init(identifier: "en-GB")
    self.sut = .init(calendar: calendar)

    let hour = calendar.date(
      from: .init(
        year: 2024,
        month: 7,
        day: 15,
        hour: 17
      )
    )!
    
    // Act
    let result = sut.format(from: hour, mode: .hour)
    
    // Assert
    XCTAssertEqual(result, "17:00")
  }
  
  func testDateMode_shouldOnlyDisplayDate() {
      // Arrange
    self.calendar.locale = .init(identifier: "en-US")
    self.sut = .init(calendar: calendar)

    let hour = calendar.date(
      from: .init(
        year: 2024,
        month: 7,
        day: 15,
        hour: 17,
        minute: 37
      )
    )!
    
      // Act
    let result = sut.format(from: hour, mode: .date)
    
      // Assert
    XCTAssertEqual(result, "July 15, 2024")
  }

  func testDateTimeMode_shouldDisplayBothDateAndTime() {
      // Arrange
    self.calendar.locale = .init(identifier: "en-US")
    self.sut = .init(calendar: calendar)

    let hour = calendar.date(
      from: .init(
        year: 2024,
        month: 7,
        day: 15,
        hour: 17,
        minute: 37
      )
    )!
    
      // Act
    let result = sut.format(from: hour, mode: .dateTime)
    
      // Assert
    XCTAssertEqual(result, "July 15, 2024 at 5:37 PM")
  }

  func testDateTimeMode_givenENGBLocale_shouldDisplayBothDateAndTime() {
      // Arrange
    self.calendar.locale = .init(identifier: "en-GB")
    self.sut = .init(calendar: calendar)
    
    let hour = calendar.date(
      from: .init(
        year: 2024,
        month: 7,
        day: 15,
        hour: 17,
        minute: 37
      )
    )!
    
      // Act
    let result = sut.format(from: hour, mode: .dateTime)
    
      // Assert
    XCTAssertEqual(result, "15 July 2024 at 17:37")
  }
  
  func testWeekMode_shouldDisplayDayRange() {
      // Arrange
    self.calendar.locale = .init(identifier: "en-GB")
    self.sut = .init(calendar: calendar)
    
    let hour = calendar.date(
      from: .init(
        year: 2024,
        month: 7,
        day: 15,
        hour: 17,
        minute: 37
      )
    )!
    
      // Act
    let result = sut.format(from: hour, mode: .week)
    
      // Assert
    XCTAssertEqual(result, "15 – 21 Jul 2024")
  }
  

  
  func testMonthYearMode_shouldNotDisplayDay() {
      // Arrange
    self.calendar.locale = .init(identifier: "en-US")
    self.sut = .init(calendar: calendar)
    
    let hour = calendar.date(
      from: .init(
        year: 2024,
        month: 7,
        day: 15,
        hour: 17,
        minute: 37
      )
    )!
    
      // Act
    let result = sut.format(from: hour, mode: .monthYear)
    
      // Assert
    XCTAssertEqual(result, "July 2024")
  }

  func testYearMode_shouldNotDisplayMonth() {
      // Arrange
    self.calendar.locale = .init(identifier: "en-US")
    self.sut = .init(calendar: calendar)
    
    let hour = calendar.date(
      from: .init(
        year: 2024,
        month: 7,
        day: 15,
        hour: 17,
        minute: 37
      )
    )!
    
      // Act
    let result = sut.format(from: hour, mode: .year)
    
      // Assert
    XCTAssertEqual(result, "2024")
  }
  

}
