import Foundation

enum BuildTarget {
  /// iPhone or iPad
  case ios
  /// macOS (without Catalyst mode)
  case mac
  /// macOS (with Catalyst mode)
  case macCatalyst
}

extension BuildTarget {
  static var current: Self {
    #if targetEnvironment(macCatalyst)
    return .macCatalyst
    #elseif os(macOS)
    return .mac
    #else
    return .ios
    #endif
  }
}
