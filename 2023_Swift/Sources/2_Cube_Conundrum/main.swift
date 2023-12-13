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
        
        var reveal = Reveal()
        
        for diceInput in diceShow {
            let diceInputParts = diceInput.split(separator: " ")
            guard let count = Int(diceInputParts[0]) else { continue }
            
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
            
        }
        gameRecord.reveals.append(reveal)
    }
    
    return gameRecord
}

var possibleGamesIDsSum: Int = 0
var gamePowerSum: Int = 0

for game in gameRecords {
    var maxRed = 0
    var maxGreen = 0
    var maxBlue = 0
    
    for reveal in game.reveals {
        maxRed = max(maxRed, reveal.red)
        maxGreen = max(maxGreen, reveal.green)
        maxBlue = max(maxBlue, reveal.blue)
    }

    // Task 1
    if maxRed <= 12 && maxGreen <= 13 && maxBlue <= 14 {
        possibleGamesIDsSum += game.id
    }
    
    // Task 2
    let gamePower = maxRed * maxGreen * maxBlue
    gamePowerSum += gamePower
}

print("[Task 2.1]", possibleGamesIDsSum)
print("[Task 2.2]", gamePowerSum)
