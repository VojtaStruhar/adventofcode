//
//  main.swift
//
//
//  Created by Vojtěch Struhár on 13.12.2023.
//

import Foundation
import AdventOfCode


struct GameRecord {
    var id: Int
    var reveals: [Reveal] = []
    
    func maxRed() -> Int {
        return reveals.map({rev in rev.red}).max()!
    }
    func maxGreen() -> Int {
        return reveals.map({rev in rev.green}).max()!
    }
    func maxBlue() -> Int {
        return reveals.map({rev in rev.blue}).max()!
    }
    
}

struct Reveal {
    var red: Int = 0
    var green: Int = 0
    var blue: Int = 0
}

let gameRecords: [GameRecord] = try! DataReader.processFile("2_Cube_Conundrum/input.txt") { line in
    let colonSeparated = line.split(separator: ":")
    let gameLabel = colonSeparated[0]
    let revealsInput = colonSeparated[1]
    
    guard let gameId = Int(gameLabel.split(separator: " ")[1]) else {
        return GameRecord(id: 0)
    }
    
    var gameRecord = GameRecord(id: gameId)
    
    let reveals = revealsInput.split(separator: ";")
    for revealString in reveals {
        let diceShow = revealString.split(separator: ",").map { el in el.trimmingCharacters(in: .whitespaces)}
        
        for diceInput in diceShow {
            let diceInputParts = diceInput.split(separator: " ")
            guard let count = Int(diceInputParts[0]) else { continue }
            
            var reveal = Reveal()
            
            switch diceInputParts[1] {
            case "red":
                reveal.red = count
            case "green":
                reveal.green = count
            case "blue":
                reveal.blue = count
            default:
                continue
            }
            
            gameRecord.reveals.append(reveal)
        }
    }
    
    return gameRecord
}

var total: Int = 0

for game in gameRecords {
    if game.maxRed() <= 12 && game.maxGreen() <= 13 && game.maxBlue() <= 14 {
        total += game.id
    }
}

print("[Task 2.1]", total)
