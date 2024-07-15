import Foundation
import SwiftUI

/// shouldUseWheelStyleDatePicker: only valid for iOS 16.4, macOS 13.3 etc. and above.
public struct ExtendedDatePickerOptions {
  let backSymbol: Image
  let forwardSymbol: Image
  // Push forward and back symbols to the edge.
  let header: ((Date) -> AnyView)?
  // Provide .infinity to push symbols to the edge
  let spacing: CGFloat?
  let shouldUseWheelStyleDatePicker: Bool
  
  public init(
    backSymbol: Image = .init(systemName: "chevron.left"),
    forwardSymbol: Image = .init(systemName: "chevron.right"),
    header: ((Date) -> AnyView)? = nil,
    spacing: CGFloat? = nil,
    shouldUseWheelStyleDatePicker: Bool = true
  ) {
    self.backSymbol = backSymbol
    self.forwardSymbol = forwardSymbol
    self.header = header
    self.spacing = spacing
    self.shouldUseWheelStyleDatePicker = shouldUseWheelStyleDatePicker
  }
}
