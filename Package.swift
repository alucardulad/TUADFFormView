// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "TUADFFormView",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .tvOS(.v12),
        .watchOS(.v5)
    ],
    products: [
        .library(
            name: "TUADFFormView",
            targets: ["TUADFFormView"]
        )
    ],
    targets: [
        .target(
            name: "TUADFFormView",
            path: "TTypeUpsAndDownsForm/TTypeUpsAndDownsForm",
            exclude: [
                "AppDelegate.h",
                "AppDelegate.m",
                "SceneDelegate.h",
                "SceneDelegate.m",
                "main.m",
                "ViewController.h",
                "ViewController.m",
                "Assets.xcassets",
                "Base.lproj"
            ],
            publicHeadersPath: "TTypeUpsAndDownsForm",
            cSettings: [
                .headerSearchPath("TTypeUpsAndDownsForm"),
                .headerSearchPath(".")
            ]
        ),
        .testTarget(
            name: "TUADFFormViewTests",
            dependencies: ["TUADFFormView"],
            path: "Tests",
            exclude: []
        )
    ]
)
