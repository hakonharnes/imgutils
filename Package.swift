// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "imgutils",
    platforms: [
        .macOS(.v11),
    ],
    products: [
        .executable(name: "imgpaste", targets: ["PasteCommand"]),
        .executable(name: "imgcopy", targets: ["CopyCommand"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "1.5.0"
        ),
    ],
    targets: [
        .target(
            name: "Common",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .executableTarget(
            name: "PasteCommand",
            dependencies: ["Common"]
        ),
        .executableTarget(
            name: "CopyCommand",
            dependencies: ["Common"]
        ),
        .testTarget(
            name: "CommonTests",
            dependencies: ["Common"]
        ),
        .testTarget(
            name: "PasteCommandTests",
            dependencies: ["PasteCommand"]
        ),
        .testTarget(
            name: "CopyCommandTests",
            dependencies: ["CopyCommand"]
        ),
    ]
)
