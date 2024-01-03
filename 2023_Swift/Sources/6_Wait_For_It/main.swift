//
//  main.swift
//
//
//  Created by Vojtěch Struhár on 17.12.2023.
//

import Foundation
import AdventOfCode


let lineParts = try DataReader.processFile("6_Wait_For_It/input.txt") { line in
    return line.split(separator: " ")
}

struct Race {
    var time: Int
    var recordDistance: Int = 0
    
    init(time: Int) {
        self.time = time
    }
}

extension Race: CustomStringConvertible {
    var description: String {
        return "Race(\(self.time)ms, \(self.recordDistance)mm)"
    }
}

func task1() throws -> Int {

    var races: [Race] = try lineParts[0][1 ..< lineParts[0].count].map { substr in
        guard let t = Int(substr) else { throw AdventOfCodeError.BadData(message: "Expecting numbers in the time values")}
        return Race(time: t)
    }

    var i = 0
    try lineParts[1][1 ..< lineParts[1].count].forEach { substr in
        guard let d = Int(substr) else { throw AdventOfCodeError.BadData(message: "Expecting numbers in the distance values")}
        races[i].recordDistance = d
        i += 1
    }


    let waysToWin = races.map { race in
        var winConfigurations = 0
        
        for holdTime in 0 ... race.time {
            let speedPerMs = holdTime
            
            let reachedDistance = speedPerMs * (race.time - holdTime)
            
            if reachedDistance > race.recordDistance {
                winConfigurations += 1
            }
        }
        
        return winConfigurations
    }

    return waysToWin.reduce(1, *)
}


print("Result 1:", try task1())
