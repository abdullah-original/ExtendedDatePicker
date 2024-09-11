#if os(iOS) || os(macOS)
import SwiftUI

public struct ExtendedDatePicker: View {
  @State private var isPickerPresented = false
  
  public var dateFormatted: String {
    model.formattedDate(for: model.selectedDate)
  }

  @ObservedObject private var model: ExtendedDatePickerModel
  private let options: ExtendedDatePickerOptions
  
  public init(
    selectedDate: Binding<Date>,
    dateRange: ClosedRange<Date>,
    mode: DateMode = .date,
    calendar: Calendar = .current,
    options: ExtendedDatePickerOptions = .init()
  ) {
    self.options = options
    self.model = .init(
      selectedDate: selectedDate,
      dateRange: dateRange,
      calendar: calendar,
      mode: mode
    )
  }
  
  public var body: some View {
    if model.displayStyle(shouldUsePopover: options.shouldUseWheelStyleDatePicker) == .popover, #available(iOS 16.4, macCatalyst 16.4, macOS 13.3, *) {
      header()
        .popover(isPresented: $isPickerPresented) {
          datePicker()
            .presentationCompactAdaptation(.popover)
            #if os(iOS)
            .datePickerStyle(.wheel)
            .pickerStyle(.wheel)
            #endif
        }
    } else if model.displayStyle(shouldUsePopover: options.shouldUseWheelStyleDatePicker) == .nativeLabel {
      datePicker()
    } else {
      header()
        .overlay(
          datePicker()
            .blendMode(.destinationOver)
        )
    }
  }
}

// MARK: - Private
private extension ExtendedDatePicker {
  
  func header() -> some View {
    HStack(spacing: options.spacing == .infinity ? .zero : options.spacing) {
      Button(action: model.didPressBack) {
        options.backSymbol
      }
      .disabled(!model.isBackButtonEnabled)
      .contentShape(Circle())
      
      if options.spacing == .infinity {
        Spacer()
      }
      
      Group {
        if let header = options.header {
          header(model.selectedDate)
        } else {
          Text(dateFormatted)
        }
      }
      .contentShape(Rectangle())
      .onTapGesture {
        isPickerPresented = true
      }
      
      if options.spacing == .infinity {
        Spacer()
      }
      
      Button(action: model.didPressForward) {
        options.forwardSymbol
      }
      .disabled(!model.isForwardButtonEnabled)
      .contentShape(Circle())
    }
    .onAppear {
      model.viewDidAppear()
    }
  }
  
  func datePicker() -> some View {
    Group {
      switch model.mode {
      case .date, .dateTime:
        DatePicker(
          "",
          selection: $model.selectedDate,
          in: model.dateRange,
          displayedComponents: model.mode.asDatePickerComponents
        )
      case .monthYear, .year, .hour, .week:
        Picker("", selection: $model.selectedDate) {
          ForEach(model.customDatePickerRange.keys.sorted(by: <), id: \.self) {
            Text(model.customDatePickerRange[$0]!).tag($0)
          }
        }
      }
    }
    .labelsHidden()
    .environment(\.calendar, model.calendar)
    .environment(\.timeZone, model.calendar.timeZone)
    .environment(\.locale, model.calendar.locale ?? .current)
  }
}

// MARK: - Preview

@available(iOS 17, macOS 14, macCatalyst 17, *)
fileprivate struct ExtendedDatePickerPreview: View {
  @State var selectedDate = Date()
  
  let calendar: Calendar = {
    var tempCal = Calendar.current
    tempCal.timeZone = .init(abbreviation: "GMT")!
    tempCal.locale = .init(identifier: "en-GB")
    return tempCal
  }()
  
  let range = Date()...(Calendar.current.date(
    byAdding: .minute,
    value: 22,
    to: .now
  ) ?? .now)
  

  var body: some View {
    ExtendedDatePicker(
      selectedDate: $selectedDate,
      dateRange: range,
      mode: .week,
      calendar: self.calendar,
      options: .init(shouldUseWheelStyleDatePicker: false)
    )
    .onChange(of: selectedDate, initial: true) {
      print(selectedDate)
    }
  }
}

@available(iOS 17, macOS 14, macCatalyst 17, *)
#Preview {
  ExtendedDatePickerPreview()
    .frame(width: 500, height: 500)
}
#endif


