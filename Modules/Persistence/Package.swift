// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "Persistence",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Persistence", targets: ["Persistence"])
    ],
    dependencies: [
        .package(path: "../Models")
    ],
    targets: [
        .target(
            name: "Persistence",
            dependencies: ["Models"]
        )
    ],
    swiftLanguageModes: [.v6]
)
