//
//  Bundle-Decodable.swift
//  MoonShotApp
//
//  Created by Nick Pavlov on 2/19/23.
//

import Foundation

extension Bundle {
    
    // Creating method to get data from JSON
    func decode<T: Codable>(_ file: String) -> T {
        
        // Creating path to data
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        // Getting data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        // Formatting date
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        // Adding data to our model
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}

