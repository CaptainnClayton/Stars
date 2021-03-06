//
//  StarsController.swift
//  Stars (iOSPT6)
//
//  Created by Clayton Watkins on 4/23/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation

class StarController {
    init() {
        self.loadFromPersistentStore()
    }
    // Data set - 1 source of truth
    private(set) var stars: [Star] = []
    
    // CRUD Function
    // Create
    @discardableResult func createStar(with name: String, distance: Double) -> Star {
        let star = Star(name: name, distance: distance)
        stars.append(star)
        self.saveToPersistentStore()
        return star
    }

    // Read
    
    
    // Update
    
    
    // Delete
    
    
    
    /// Persistence Functions
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        // We want to access the documents directory in the user's domain
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask) .first else { return nil }
        // Create a new plist file in that directory
        return directory.appendingPathComponent("stars.plist")
    }
    // Save
    private func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        // Turn object into data
        // Write data to file
        
        
        // Stars Array -> Data -> Write to plist file
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(stars)
            try data.write(to: url)
        } catch {
            NSLog("Error saving stars data: \(error)")
        }
    }
    
    // Load
    private func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = persistentFileURL,
            fm.fileExists(atPath: url.path) else { return }
        
        // Plist file -> Data -> Stars
        do{
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            stars = try decoder.decode([Star].self, from: data)
        } catch {
            NSLog("Error loading stars data: \(error)")
        }
    }
}
