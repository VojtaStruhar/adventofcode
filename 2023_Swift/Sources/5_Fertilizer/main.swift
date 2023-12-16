//
//  main.swift
//  
//
//  Created by Vojtěch Struhár on 14.12.2023.
//

import Foundation
import AdventOfCode


struct Mapping {
    var source: [Range<Int>] = []
    var destination: [Int] = []
    
    mutating func addElement(sourceIndex: Int, destinationIndex: Int, rangeSize: Int) {
        self.source.append(sourceIndex ..< sourceIndex + rangeSize)
        self.destination.append(destinationIndex)
    }
    
    func transform(_ element: Int) -> Int {
        for i in 0 ..< source.count {
            let srcRange = source[i]
            if srcRange.contains(element) {
                let offset = element - srcRange.lowerBound
                
                return destination[i] + offset
            }
        }
        return element
    }
}

// Load the file as simple lines here. Some more advanced processing is needed.

let lines = try DataReader.readFile("5_Fertilizer/input.txt").split(separator: "\n")

var seeds = lines[0].split(separator: ":")[1].split(separator: " ").map({ subs in
    return Int(subs)! // I know they are numbers
})

var mappings: [Mapping] = []
var currentMapping: Mapping? = nil

for line in lines.dropFirst(1) {
    if line.contains("map") {
        if let currentMapping = currentMapping {
            mappings.append(currentMapping)
        }
        currentMapping = Mapping()
        continue
    }
    
    let numbers = line.split(separator: " ").map { subs in
        return Int(subs)!
    }
    
    if !numbers.isEmpty {
        currentMapping?.addElement(sourceIndex: numbers[1], destinationIndex: numbers[0], rangeSize: numbers[2])
    }
}

// Append the WIP one when the loop ends
if let currentMapping = currentMapping {
    mappings.append(currentMapping)
}


let seedLocations = seeds.map { seed in
    return mappings.transform(seed)
}

print("Seed locations:", seedLocations)
print(" - min:", seedLocations.min(by: <) ?? -1)


extension [Mapping] {
    func transform(_ value: Int) -> Int {
        var result = value
        self.forEach { m in
            result = m.transform(result)
        }
        return result
    }
}
