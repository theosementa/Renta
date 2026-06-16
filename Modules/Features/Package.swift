// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Objects", targets: ["Objects"]),
        .library(name: "Settings", targets: ["Settings"])
    ],
    dependencies: [
        .package(path: "../DataSources"),
        .package(path: "../Models"),
        .package(path: "../DesignSystem"),
        .package(path: "../Navigation"),
        .package(url: "https://github.com/izyumkin/MCEmojiPicker", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Objects",
            dependencies: [
                "DataSources",
                "Models",
                "DesignSystem",
                "Navigation",
                "MCEmojiPicker"
            ]
        ),
        .target(
            name: "Settings",
            dependencies: [
                "DataSources",
                "Models",
                "DesignSystem",
                "Navigation"
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
