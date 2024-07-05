// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "mcpp",
    defaultLocalization: "en",
    platforms: [
     .macOS(.v14),
     .iOS(.v12),
   ],
    products: [
        .library(name: "mcpp", targets: ["mcpp"])
    ],
    targets: [
        .target(
            name: "mcpp",
            path: "./",
            publicHeadersPath: ".",
            cSettings: [
                .unsafeFlags(["-Wno-implicit-function-declaration", "-Wno-deprecated-non-prototype"])
            ]
        )
    ]
)
