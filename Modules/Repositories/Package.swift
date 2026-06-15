// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "Repositories",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Repositories", targets: ["Repositories"])
    ],
    dependencies: [
        .package(path: "../Persistence")
    ],
    targets: [
        .target(
            name: "Repositories",
            dependencies: ["Persistence"]
        )
    ],
    swiftLanguageModes: [.v6]
)
