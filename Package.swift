// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "volume",
    products: [
        .executable(name: "volume", targets: ["volume"])
    ],
    dependencies: [],
    targets: [
        .target(name: "volume",
        dependencies: [])
    ]
)
