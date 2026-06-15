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
        .package(path: "../Models")
    ],
    targets: [
        .target(
            name: "Objects",
            dependencies: ["DataSources", "Models"]
        )
    ],
    swiftLanguageModes: [.v6]
)
