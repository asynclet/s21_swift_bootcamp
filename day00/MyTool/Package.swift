// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Day00Common",
    products: [.library(name: "Day00Common", targets: ["Day00Common"])],
    dependencies: [],
    targets: [
        .target(name: "Day00Common")
    ]
)
