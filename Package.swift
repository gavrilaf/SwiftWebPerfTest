// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftWebPerfTest",
    products: [
        .library(name: "Configuration", targets: ["Configuration"]),
        .executable(name: "SeagullSrv", targets: ["SeagullSrv"]),
        .executable(name: "VaporSrv", targets: ["VaporSrv"]),
    ],
    dependencies: [
        .package(url: "https://github.com/gavrilaf/Seagull.git", from: "0.2.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "1.4.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0-rc"),
    ],
    targets: [
        .target(name: "Configuration", dependencies: []),
        .target(name: "SeagullSrv", dependencies: ["Configuration", "Seagull"]),
        .target(name: "VaporSrv", dependencies: ["Configuration", "Vapor"]),
    ]
)
