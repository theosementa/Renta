// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "Navigation",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Navigation", targets: ["Navigation"])
    ],
    dependencies: [
        .package(url: "https://github.com/neopixl/PharosNav-ios.git", from: "1.0.0"),
        .package(path: "../Models")
    ],
    targets: [
        .target(
            name: "Navigation",
            dependencies: [
                .product(name: "PharosNav", package: "PharosNav-ios"),
                "Models"
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
