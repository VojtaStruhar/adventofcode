//
//  DataReader.swift
//
//
//  Created by Vojtěch Struhár on 13.12.2023.
//

import Foundation

public enum AdventOfCodeError: Error {
    case FileNotFound(path: String)
}


public class DataReader {
    static let projectPath = "/Users/vojtechstruhar/Development/AdventOfCode/2023_Swift/Sources/"
    
    public static func readFile(_ relativePath: String) throws -> String  {
        let filePath = projectPath + relativePath
        guard FileManager().fileExists(atPath: filePath ) else {
            throw AdventOfCodeError.FileNotFound(path: filePath)
        }
            
        let file = try String(contentsOfFile: filePath)
        return file
    }
    
    /// Parses lines of the file into custom structures with a provided function.
    public static func processFile<T>(_ relativePath: String, _ transform: (_ line: Substring) -> T) throws -> [T] {
        let lines = try readFile(relativePath).split(separator: "\n")
        return lines.map(transform)
    }
}


public func ipow(_ base: Int, _ ex: Int) -> Int {
    var result = 1
    for _ in 0 ..< ex {
        result *= base
    }
    return result    
}
