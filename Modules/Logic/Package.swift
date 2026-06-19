// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Logic",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Logic",
            targets: ["Logic"]
        )
    ],
    dependencies: [
        .package(path: "../Models")
    ],
    targets: [
        .target(
            name: "Logic",
            dependencies: ["Models"]
        ),
        .testTarget(
            name: "LogicTests",
            dependencies: ["Logic", "Models"]
        )
    ],
    swiftLanguageModes: [.v6]
)
