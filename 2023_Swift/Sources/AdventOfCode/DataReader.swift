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
}
