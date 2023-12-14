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
        let m = matches()
        if m == 0 {
            return 0
        }
        return ipow(2, m - 1)
    }
    
    func matches() -> Int {
        var registry: [Int: Bool] = [:]
        for n in numbers { registry[n] = true }
        
        var score = 0

        for w in winning where registry[w] ?? false {
            score += 1
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

var cardCount: [Int] = [Int](repeating: 1, count: cards.count)

for i in 0 ..< cards.count {
    let card = cards[i]
    for j in 0 ..< card.matches() {
        // The assignment says this will not run out of bounds
        cardCount[i + j + 1] += cardCount[i]
    }
}


print("Total cards:", cardCount.reduce(0, +))
