@testable import ExtendedDatePicker
import XCTest

final class ExtendedDatePickerModelTests: XCTestCase {
  
  private var sut: ExtendedDatePickerModel!
  private var selectedDate: Date!
  private var dateRange: ClosedRange<Date>!
  private var calendar: Calendar!
  private var components: DateMode!
  
  override func setUp() {
    super.setUp()
    calendar = .current
    calendar.locale = .init(identifier: "en-US")
    
    selectedDate = Date()
  }
  
  func testYearOptions_whenDateRangeIs1February2022To5May2022_shouldReturnOnly2022() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2022, month: 2, day: 1).date!,
        upper: DateComponents(calendar: calendar, year: 2022, month: 5, day: 15).date!
      )
    )
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .year
    )
    
    let result = sut.yearOptions()
    
    XCTAssertEqual(result.count, 1)
    XCTAssertEqual(result.first?.value, "2022")
  }
  
  func testYearOptions_whenDateRangeIs1February2022To5May2023_shouldReturn2022And2023() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2022, month: 2, day: 1).date!,
        upper: DateComponents(calendar: calendar, year: 2023, month: 5, day: 5).date!
      )
    )
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .year
    )
    
    let result = sut.yearOptions()
    
    XCTAssertEqual(result.count, 2)
    XCTAssert(result.contains { $1 == "2022" })
    XCTAssert(result.contains { $1 == "2023" })
  }
  
  func testMonthYearOptions_whenDateRangeIs1February2022To5May2022_shouldReturnContainAllMonths() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2022, month: 2, day: 1).date!,
        upper: DateComponents(calendar: calendar, year: 2022, month: 5, day: 5).date!
      )
    )
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .monthYear
    )
    
    let result = sut.monthYearOptions()
    
    XCTAssertEqual(result.count, 4)
    XCTAssertEqual(result.sorted(by: <).first?.value, "February 2022" )
    XCTAssertEqual(result.sorted(by: <).last?.value, "May 2022" )
  }
  
  func testMonthYearOptions_whenDateRangeIs1February2022To5May2023_shouldReturnContainAllMonths() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2022, month: 2, day: 1).date!,
        upper: DateComponents(calendar: calendar, year: 2023, month: 5, day: 5).date!
      )
    )
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .monthYear
    )
    
    let result = sut.monthYearOptions()
    
    XCTAssertEqual(result.count, 16)
    XCTAssertEqual(result.sorted(by: <).first?.value, "February 2022" )
    XCTAssertEqual(result.sorted(by: <).last?.value, "May 2023")
  }
  
  func testMonthYearOptions_whenDateRangeIs1February2022To5May2024_shouldReturnContainAllMonths() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2022, month: 2, day: 1).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 5, day: 5).date!
      )
    )
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .monthYear
    )
    
    let result = sut.monthYearOptions()
    
    XCTAssertEqual(result.count, 28)
    XCTAssertEqual(result.sorted(by: <).first?.value, "February 2022" )
    XCTAssertEqual(result.sorted(by: <).last?.value, "May 2024")
  }
  
  func testWeekOptions_whenDateRangeIs14March2024To5May2024_shouldReturn8Weeks() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2024, month: 3, day: 14).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 5, day: 5).date!
      )
    )
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .week
    )
    
    let result = sut.weekOptions()
    
    XCTAssertEqual(result.count, 8)
  }
  
  func testWeekOptions_whenDateRangeIs14March2024To2May2024_shouldReturn7Weeks() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2024, month: 3, day: 14).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 5, day: 2).date!
      )
    )
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .week
    )
    
    let result = sut.weekOptions()
    
    XCTAssertEqual(result.count, 7)
  }
  
  func testWeekOptions_whenDateRangeIs14March2024To1May2024_shouldReturn7Weeks() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2024, month: 3, day: 14).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 5, day: 1).date!
      )
    )
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .week
    )
    
    let result = sut.weekOptions()
    
    XCTAssertEqual(result.count, 7)
  }

  func testHourOptions_whenDateRangeIs2February20241700To1February20242130_shouldReturn5Hours() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2024, month: 2, day: 2, hour: 17).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 2, day: 2, hour: 21, minute: 30).date!
      )
    )
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .week
    )
    
    let result = sut.hourOptions()
    
    XCTAssertEqual(result.count, 5)
  }

  func testHourOptions_whenDateRangeIs2February20241645To1February20242130_shouldReturn6Hours() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2024, month: 2, day: 2, hour: 16, minute: 45).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 2, day: 2, hour: 21, minute: 30).date!
      )
    )
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .week
    )
    
    let result = sut.hourOptions()
    
    XCTAssertEqual(result.count, 6)
  }

  
  func testdidPressBack_whenSelectedDateIsUpdatedToDateRangeLowerBound_isBackButtonEnabledIsFalse() {
    selectedDate = DateComponents(calendar: calendar, year: 2022, month: 2, day: 2).date!
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2022, month: 2, day: 1).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 5, day: 5).date!
      )
    )
    
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .monthYear
    )
    
    sut.didPressBack()
    
    XCTAssertEqual(sut.isBackButtonEnabled, false)
  }
  
  func testdidPressForward_whenSelectedDateIsNotDateRangeLowerBound_isBackButtonEnabledIsTrue() {
    selectedDate = DateComponents(calendar: calendar, year: 2022, month: 2, day: 2).date!
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2022, month: 2, day: 1).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 5, day: 5).date!
      )
    )
    
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .monthYear
    )
    
    sut.didPressForward()
    
    XCTAssertEqual(sut.isBackButtonEnabled, true)
  }
  
  func testdidPressForward_whenSelectedDateIsDateRangeLowerBound_isForwardButtonEnabledIsTrue() {
    selectedDate = DateComponents(calendar: calendar, year: 2022, month: 2, day: 2).date!
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2022, month: 2, day: 1).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 5, day: 5).date!
      )
    )
    
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .monthYear
    )
    
    sut.didPressForward()
    
    XCTAssertEqual(sut.isForwardButtonEnabled, true)
  }

  func testdidPressForward_whenSelectedDateIsDateRangeUpperBound_isForwardButtonEnabledIsFalse() {
    selectedDate = DateComponents(calendar: calendar, year: 2024, month: 5, day: 4).date!
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2022, month: 2, day: 1).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 5, day: 5).date!
      )
    )
    
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .monthYear
    )
    
    sut.didPressForward()
    
    XCTAssertEqual(sut.isForwardButtonEnabled, false)
  }
  
  func testdidPressForward_whenNewDateIsGreaterThanDateRangeUpperBound_selectedDateShouldNotChange() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2022, month: 2, day: 1).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 5, day: 5).date!
      )
    )
    selectedDate = input.upperBound
    
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .date
    )
    
    sut.didPressForward()
    
    XCTAssertEqual(selectedDate, input.upperBound)
  }

  func testdidPressBack_whenNewDateIsLessThanDateRangeLowerBound_selectedDateShouldNotChange() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2022, month: 2, day: 1).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 5, day: 5).date!
      )
    )
    selectedDate = input.lowerBound
    
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .date
    )
    
    sut.didPressBack()
    
    XCTAssertEqual(selectedDate, input.lowerBound)
  }
  
  func testdidPressForward_whenNewDateIsNotGreaterThanDateRangeUpperBound_selectedDateShouldChange() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2022, month: 2, day: 1).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 5, day: 5).date!
      )
    )
    selectedDate = DateComponents(calendar: calendar, year: 2024, month: 5, day: 4).date!
    
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .date
    )
    
    sut.didPressForward()
    
    XCTAssertEqual(selectedDate, input.upperBound)
  }
  
  func testdidPressBack_whenNewDateIsNotLessThanDateRangeLowerBound_selectedDateShouldNotChange() {
    let input = ClosedRange(
      uncheckedBounds: (
        lower: DateComponents(calendar: calendar, year: 2022, month: 2, day: 1).date!,
        upper: DateComponents(calendar: calendar, year: 2024, month: 5, day: 5).date!
      )
    )
    selectedDate = DateComponents(calendar: calendar, year: 2022, month: 2, day: 2).date!
    
    
    sut = .init(
      selectedDate: .init(get: { self.selectedDate }, set: { self.selectedDate = $0 }),
      dateRange: input,
      calendar: calendar,
      mode: .date
    )
    
    sut.didPressBack()
    
    XCTAssertEqual(selectedDate, input.lowerBound)
  }
  

}
