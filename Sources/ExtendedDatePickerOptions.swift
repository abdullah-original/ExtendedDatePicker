import Foundation
import SwiftUI

public struct ExtendedDatePickerOptions: Sendable {
    let backSymbol: Image
    let forwardSymbol: Image
    /// Push forward and back symbols to the edge.
    let header: (@MainActor (Date) -> AnyView)?
    /// Provide .infinity to push symbols to the edge
    let spacing: CGFloat?
    /// Only valid for iOS 16.4  etc. and above. Ignored for macOS.
    let shouldUseWheelStyleDatePicker: Bool
    
    public init(
        backSymbol: Image = .init(systemName: "chevron.left"),
        forwardSymbol: Image = .init(systemName: "chevron.right"),
        header: (@MainActor (Date) -> AnyView)? = nil,
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
