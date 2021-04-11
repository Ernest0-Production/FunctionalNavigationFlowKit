// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FunctionalNavigationFlowKit",
    products: [
        .library(
            name: "FunctionalNavigationFlowKit",
            targets: ["FunctionalNavigationFlowKit"]),
    ],
    targets: [
        .target(
            name: "FunctionalNavigationFlowKit",
            dependencies: []),
        .testTarget(
            name: "FunctionalNavigationFlowKitTests",
            dependencies: ["FunctionalNavigationFlowKit"]),
    ]
)
