// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Calcium",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Calcium",
            targets: ["Calcium"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Juanpe/SkeletonView.git", .upToNextMajor(from: "1.30.4")),
        .package(url: "https://github.com/GoodRequest/GRProvider", branch: "master")
    ],
    targets: [
        .target(
            name: "Calcium",
            dependencies: ["GRProvider", "SkeletonView"]
        ),
        .testTarget(
            name: "CalciumTests",
            dependencies: ["Calcium"]
        ),
    ]
)
