// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PokeAPIService",
    platforms: [
        .macOS(.v15), .iOS(.v18),
    ],
    products: [
        .library(
            name: "PokeAPIService",
            targets: ["PokeAPIService"]
        ),
    ],
    targets: [
        .target(name: "PokeAPIService"),
        .testTarget(
            name: "PokeAPIServiceTests",
            dependencies: ["PokeAPIService"]
        ),
    ]
)
