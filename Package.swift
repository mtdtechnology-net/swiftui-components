// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Components",
    platforms: [
        .iOS(.v15),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Components",
            targets: ["Components"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/mtdtechnology-net/swiftui-loading-view", from: "25.2.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Components",
            dependencies: [
                .product(name: "LoadingView", package: "swiftui-loading-view")
            ],
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                .define("SPM"),
                .define("BUILD_LIBRARY_FOR_DISTRIBUTION", .when(configuration: .release))
            ]
        ),
        .testTarget(
            name: "ComponentsTests",
            dependencies: ["Components"]
        ),
    ],
    swiftLanguageModes: [.version("6")]
)
