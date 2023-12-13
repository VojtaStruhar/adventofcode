// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "2023_Swift",
    products: [
        .executable(name: "1_Trebuchet", targets: ["1_Trebuchet"]),
        .executable(name: "2_Cube_Conundrum", targets: ["2_Cube_Conundrum"]),
        
    ],
    
    targets: [
        .executableTarget(name: "1_Trebuchet", dependencies: ["AdventOfCode"]),
        .executableTarget(name: "2_Cube_Conundrum", dependencies: ["AdventOfCode"]),
        
        // Shared folder with all common goodies
        .target(name: "AdventOfCode")
    ]
)
