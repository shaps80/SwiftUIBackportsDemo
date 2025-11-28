// swift-tools-version: 6.2
import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "DemoMacros",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "DemoMacros",
            targets: ["DemoMacros"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "602.0.0-latest"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        // Macro implementation that performs the source transformation of a macro.
        .macro(
            name: "DemoMacrosMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),

        // Library that exposes a macro as part of its API, which is used in client programs.
        .target(name: "DemoMacros", dependencies: ["DemoMacrosMacros"]),

        // A test target used to develop the macro implementation.
        .testTarget(
            name: "DemoMacrosTests",
            dependencies: [
                "DemoMacrosMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        )
    ]
)
