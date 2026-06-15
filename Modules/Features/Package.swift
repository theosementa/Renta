// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Objects", targets: ["Objects"])
    ],
    dependencies: [
        .package(path: "../DataSources"),
        .package(path: "../Models"),
        .package(path: "../DesignSystem"),
        .package(url: "https://github.com/izyumkin/MCEmojiPicker", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Objects",
            dependencies: ["DataSources", "Models", "DesignSystem", "MCEmojiPicker"]
        )
    ],
    swiftLanguageModes: [.v6]
)
