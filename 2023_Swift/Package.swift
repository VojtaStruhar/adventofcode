// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "2023_Swift",
    products: [
        .executable(name: "1_Trebuchet", targets: ["1_Trebuchet"]),
        .executable(name: "2_Cube_Conundrum", targets: ["2_Cube_Conundrum"]),
        .executable(name: "3_Gear_Ratios", targets: ["3_Gear_Ratios"]),
        .executable(name: "4_Scratchcards", targets: ["4_Scratchcards"]),
        .executable(name: "5_Fertilizer", targets: ["5_Fertilizer"]),
        .executable(name: "6_Wait_For_It", targets: ["6_Wait_For_It"]),
        .executable(name: "7_Camel_Cards", targets: ["7_Camel_Cards"]),
        .executable(name: "14_Parabolic_Reflector_Dish", targets: ["14_Parabolic_Reflector_Dish"]),
    ],
    
    targets: [
        .executableTarget(name: "1_Trebuchet", dependencies: ["AdventOfCode"]),
        .executableTarget(name: "2_Cube_Conundrum", dependencies: ["AdventOfCode"]),
        .executableTarget(name: "3_Gear_Ratios", dependencies: ["AdventOfCode"]),
        .executableTarget(name: "4_Scratchcards", dependencies: ["AdventOfCode"]),
        .executableTarget(name: "5_Fertilizer", dependencies: ["AdventOfCode"]),
        .executableTarget(name: "6_Wait_For_It", dependencies: ["AdventOfCode"]),
        .executableTarget(name: "7_Camel_Cards", dependencies: ["AdventOfCode"]),
        .executableTarget(name: "14_Parabolic_Reflector_Dish", dependencies: ["AdventOfCode"]),
        
        // Shared folder with all common goodies
        .target(name: "AdventOfCode")
    ]
)
