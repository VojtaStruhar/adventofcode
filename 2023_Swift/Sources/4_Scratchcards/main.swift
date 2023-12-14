//
//  main.swift
//
//
//  Created by Vojtěch Struhár on 14.12.2023.
//

import Foundation
import AdventOfCode

struct Scratchcard {
    let winning: [Int]
    let numbers: [Int]
    
    func points() -> Int {
        var registry: [Int: Bool] = [:]
        for n in numbers { registry[n] = true }
        
        var score = 0

        for w in winning {
            if registry[w] ?? false {
                if score == 0 {
                    score = 1
                } else {
                    score *= 2
                }
            }
        }
        
        return score
    }
}

let cards: [Scratchcard] = try DataReader.processFile("4_Scratchcards/input.txt") { line in
    let colonParts = line.split(separator: ":")
    let numberParts = colonParts[1].split(separator: "|")
    
    return Scratchcard(
        winning: numberParts[0].split(separator: " ").map({ s in Int(s)! }),
        numbers: numberParts[1].split(separator: " ").map({ s in Int(s)! }))
}

let points: Int = cards.reduce(0) { partialResult, card in
    partialResult + card.points()
}

print("Points:", points)
