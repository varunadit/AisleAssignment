// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "aisle",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AisleUI",
            targets: ["AisleUI"]
        ),
        .library(
            name: "AppFeature",
            targets: ["AppFeature"]
        ),
//        .library(
//            name: "ServerRouter",
//            targets: ["ServerRouter"]
//        ),
        .library(
            name: "SharedModels",
            targets: ["SharedModels"]
        ),
        .library(
            name: "LoginFeature",
            targets: ["LoginFeature"]
        ),
        .library(
            name: "APIClient",
            targets: ["APIClient"]
        ),
        .library(
            name: "HomeFeature",
            targets: ["HomeFeature"]
        ),
        .library(
            name: "TabFeature",
            targets: ["TabFeature"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            exact: "1.15.0"
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-dependencies",
            exact: "1.4.1"
        )

    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AisleUI"
        ),
        .target(
            name: "AppFeature",
            dependencies: [
                "AisleUI",
                "LoginFeature",
                "HomeFeature",
                "TabFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: [
                "AppFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "SharedModels"
        ),
        .target(
            name: "LoginFeature",
            dependencies: [
                "AisleUI",
                "APIClient",
                "HomeFeature",
                "TabFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "LoginFeatureTests",
            dependencies: [
                "LoginFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "APIClient",
            dependencies: [
                "SharedModels",
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies")
            ]
        ),
        .target(
            name: "HomeFeature",
            dependencies: [
                "AisleUI",
                "APIClient",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "TabFeature",
            dependencies: [
                "AisleUI",
                "SharedModels",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
    ]
)
