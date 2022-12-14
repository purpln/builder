// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "app", platforms: [.macOS(.v12)],
    products: [
        .executable(name: "app", targets: ["Application"])
    ],
    targets: [
        .executableTarget(name: "Application", dependencies: [
            .target(name: "Architecture"),
        ]),
        .target(name: "Architecture"),
    ]
)
