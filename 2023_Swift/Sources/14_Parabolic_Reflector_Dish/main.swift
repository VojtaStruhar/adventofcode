//
//  main.swift
//
//
//  Created by Vojtěch Struhár on 14.12.2023.
//

import Foundation
import AdventOfCode


enum PlatformElement: CustomStringConvertible {
    case stone(movable: Bool)
    case air
    
    var description: String {
        switch self {
        case .stone(let movable): movable ? "O" : "#"
        case .air: " "
        }
    }
}


var stones: [[PlatformElement]] = try DataReader.processFile("14_Parabolic_Reflector_Dish/input.txt") { line in
    return line.map { c in
        return switch c {
        case "O": .stone(movable: true)
        case "#": .stone(movable: false)
        default: .air
        }
    }
}

// 1. Traverse the grid by columns
// 2. Mark the furthest position you can roll a stone to. Could be edge of a platform, immovable stone or a column of stones
// 3. When you encounter a stone that can roll, swap it with the empty space it will take up and increment the furthest position

for x in 0 ..< stones[0].count {
    var furthestFreeSlot = 0
    for y in 0 ..< stones.count {
        
        let current = stones[y][x]
        
        switch current {
        case .stone(movable: false): furthestFreeSlot = y + 1
        case .stone(movable: true):
            swapY(grid: &stones, x: x, y1: y, y2: furthestFreeSlot)
            furthestFreeSlot += 1
        case .air: break
        }
        
    }
}


var weight = stones.count
var totalWeight = 0

stones.forEach { row in
    row.forEach { el in
        if case .stone(movable: true) = el {
            totalWeight += weight
        }
    }
    weight -= 1
}


print("Total weight:", totalWeight)

func swapY<T>(grid: inout [[T]], x: Int, y1: Int, y2: Int ) {
    let first = grid[y1][x]
    let second = grid[y2][x]
    
    grid[y2][x] = first
    grid[y1][x] = second
}
