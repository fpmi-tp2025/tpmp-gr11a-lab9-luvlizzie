//
//  PoetsDataManager.swift
//  BelarusianPoets
//
//  Created by Кудинова Елизавета on 10.05.2026.
//

import Foundation

class PoetsDataManager {
    
    static let shared = PoetsDataManager()
    private init() {}
    
    private let fileName = "poets"
    
    func loadPoets() -> [Poet] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "plist"),
              let data = try? Data(contentsOf: url) else {
            return []
        }
        
        let decoder = PropertyListDecoder()
        guard let poets = try? decoder.decode([Poet].self, from: data) else {
            return []
        }
        
        return poets
    }
}
