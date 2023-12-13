// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import AdventOfCode


var lines: [String.SubSequence]

do {
    let fileContents = try DataReader.readFile("1_Trebuchet/input.txt")
    lines = fileContents.split(separator: "\n")
} catch AdventOfCodeError.FileNotFound(path: let searchedPath)  {
    print("File not found at", searchedPath)
    exit(1)
}


var total: Int = 0

for line in lines {
    var first: Int = -1
    var last: Int = -1
    
    for letter in line where letter.isWholeNumber {
        if first == -1 {
            first = letter.wholeNumberValue!
        }
        last = letter.wholeNumberValue!
    }
    total += first * 10 + last
}
print("Total:", total)
