// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "ExtendedDatePicker",
  platforms: [.iOS(.v14), .macCatalyst(.v14), .macOS(.v11)],
  products: [
    .library(
      name: "ExtendedDatePicker",
      type: .static,
      targets: ["ExtendedDatePicker"]
    ),
    .library(
      name: "ExtendedDatePicker-Dynamic",
      type: .dynamic,
      targets: ["ExtendedDatePicker"]
    )
  ],
  dependencies: [],
  targets: [
    .target(
      name: "ExtendedDatePicker",
      dependencies: [],
      path: "Sources"
    ),
    .testTarget(
      name: "ExtendedDatePickerTests",
      dependencies: ["ExtendedDatePicker"],
      path: "Tests"
    ),
  ]
)
