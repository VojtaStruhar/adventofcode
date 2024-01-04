//
//  main.swift
//
//
//  Created by Vojtěch Struhár on 04.01.2024.
//

import Foundation
import AdventOfCode

let FiveOfAKind: Int = 7
let FourOfAKind: Int = 6
let Fullhouse: Int = 5
let ThreeOfAKind: Int = 4
let TwoPair: Int = 3
let Pair: Int = 2
//let HighCard: Int = 1

struct Play {
    let cards: [Int]
    let bid: Int
    
    let handStrength: Int
    
    init(cards: [Int], bid: Int) {
        self.cards = cards
        self.bid = bid
        self.handStrength = calculateHandStrength(cards: cards)
    }
    
    
}

extension Play: CustomStringConvertible {
    var description: String {
        return "Play(\(self.cards), $\(self.bid))"
    }
}

func calculateHandStrength(cards: [Int]) -> Int {
    var result: Int = 0
    
    var appearances: [Int] = Array(repeating: 0, count: 15) // because Ace is 14
    for card in cards {
        appearances[card] += 1
    }
    
    // Analyze the count of cards
    
    var fivesFound = 0
    var foursFound = 0
    var threesFound = 0
    var pairsFound = 0
    
    for app in appearances {
        switch app {
        case 5:
            fivesFound += 1
        case 4:
            foursFound += 1
        case 3:
            threesFound += 1
        case 2:
            pairsFound += 1
        default:
            continue
        }
    }
    
    // Recognize card combinations
    if fivesFound > 0 {
        result += FiveOfAKind
    } else if foursFound > 0 {
        result += FourOfAKind
    } else if threesFound == 1 && pairsFound == 1 {
        result += Fullhouse
    } else if threesFound == 1 && pairsFound == 0 {
        result += ThreeOfAKind
    } else if pairsFound == 2 {
        result += TwoPair
    } else if pairsFound == 1 {
        result += Pair
    } // No need for high card I guess
    
    
    // Embed the rest of the cards into the result - in order!
    
    for card in cards {
        result = result << 5
        result += card
    }
    
    return result
}

let cardStrength: [Character: Int] = [
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6,
    "7": 7,
    "8": 8,
    "9": 9,
    "T": 10,
    "J": 11,
    "Q": 12,
    "K": 13,
    "A": 14
]

let plays = try DataReader.processFile("7_Camel_Cards/input.txt") { line in
    let parts = line.split(separator: " ")
    let cards = try! parts[0].map { c in
        guard let val = cardStrength[c] else { throw AdventOfCodeError.BadData(message: "Unable to find a poker card's strength value")}
        return val
    }
    let bid = Int(parts[1]) ?? 0
    return Play(cards: cards, bid: bid)
}

let sortedPlays = plays.sorted { play1, play2 in
    return play1.handStrength < play2.handStrength
}

var rank = 1
let winnings = sortedPlays.reduce(0) { partialResult, play in
    defer { rank += 1 }
    return partialResult + (play.bid * rank)
}
print("Winnings:", winnings)

