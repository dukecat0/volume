// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "volume",
    products: [
        .executable(name: "volume", targets: ["volume"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.1")
    ],
    targets: [
        .target(name: "volume",
        dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
    ]
)
