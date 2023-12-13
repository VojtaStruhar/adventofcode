//
//  main.swift
//
//
//  Created by Vojtěch Struhár on 13.12.2023.
//

import Foundation
import AdventOfCode


enum ManualEntry: CustomStringConvertible {
    case symbol(index: Int, gearbox: Bool)
    case number(start: Int, end: Int, value: Int)
    
    var description: String {
        switch self {
        case .symbol(let index, let gb): return "<\(gb ? "Gearbox" : "Symbol") \(index)>"
        case .number(let start, let end, let val): return "<Number \(start)-\(end): \(val)>"
        }
    }
}

let lines = try DataReader.processFile("3_Gear_Ratios/input.txt") { line in
    return line
}


var entries: [[ManualEntry]] = []

for line in lines {
    entries.append([])
    
    var currentIndex = 0
    
    var numberDetected = false
    var numberStartIndex = 0
    var numberValue = 0
    
    for letter in line {
        // Check if we have a number going on
        if letter.isWholeNumber {
            if !numberDetected {
                numberDetected = true
                numberStartIndex = currentIndex
            }
            numberValue = numberValue * 10 + Int(String(letter))!
            
        } else {
            if numberDetected {
                // Mark the entry
                entries[entries.count - 1].append(.number(start: numberStartIndex, end: currentIndex - 1, value: numberValue))
                // Reset state
                numberDetected = false
                numberStartIndex = 0
                numberValue = 0
            }
            
            // Check if we have a symbol
            if letter != "." {
                entries[entries.count - 1].append(.symbol(index: currentIndex, gearbox: letter == "*"))
            }
        }
        
        currentIndex += 1
    }
    
    // Handle numbers at the end of the line
    if numberDetected {
        // Mark the entry
        entries[entries.count - 1].append(.number(start: numberStartIndex, end: currentIndex - 1, value: numberValue))
        
    }
}


var partNumbersTotal = 0
var gearRatiosTotal = 0

for y in 0 ..< entries.count {
    let row = entries[y]
    
    for element in row {
        switch element {
        case .number(_, _, value: let value):
            // Find if there are any surrounding symbols. Task 1
            var partNumberContribution: Int {
                if y > 0 {
                    // check row above
                    for sym in entries[y - 1] {
                        if case .symbol(_, _) = sym, areAround(symbol: sym, around: element) {
                            return value // succcess
                        }
                    }
                }
                // check current row
                for sym in row {
                    if case .symbol(_, _) = sym, areAround(symbol: sym, around: element) {
                        return value // succcess
                    }
                }
                if y < entries.count - 1 {
                    // check row below
                    for sym in entries[y + 1] {
                        if case .symbol(_, _) = sym, areAround(symbol: sym, around: element) {
                            return value // succcess
                        }
                    }
                }
                return 0
            }
            partNumbersTotal += partNumberContribution
         
        case .symbol(_, true):
            
            var gearRatio: Int {
                var around = 0
                var ratio = 1
                if y > 0 {
                    // check row above
                    for num in entries[y - 1] {
                        if case .number(_, _, let value) = num, areAround(symbol: element, around: num) {
                            around += 1
                            ratio *= value
                            if around == 2 {
                                return ratio
                            }
                        }
                    }
                }
                
                // check current row
                for num in row {
                    if case .number(_, _, let value) = num, areAround(symbol: element, around: num) {
                        around += 1
                        ratio *= value
                        if around == 2 {
                            return ratio
                        }
                    }
                }
                if y < entries.count - 1 {
                    // check row below
                    for num in entries[y + 1] {
                        if case .number(_, _, let value) = num, areAround(symbol: element, around: num) {
                            around += 1
                            ratio *= value
                            if around == 2 {
                                return ratio
                            }
                        }
                    }
                }
                return 0
            }
            gearRatiosTotal += gearRatio
        default:
            continue        }
    }
}

print("Parts:", partNumbersTotal) // Task 1
print("Gear ratios:", gearRatiosTotal) // Task 2

func areAround(symbol: ManualEntry, around number: ManualEntry) -> Bool {
    if case .symbol(let index, _) = symbol, case .number(let start, let end, _) = number {
        return ((start - 1)...(end + 1)).contains(index)
    }
    print("Bad input")
    return false
}
