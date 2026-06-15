// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "DataSources",
    platforms: [.iOS(.v17)],
    products: [.library(name: "DataSources", targets: ["DataSources"])],
    dependencies: [.package(path: "../Repositories")],
    targets: [.target(name: "DataSources", dependencies: ["Repositories"])],
    swiftLanguageModes: [.v6]
)
