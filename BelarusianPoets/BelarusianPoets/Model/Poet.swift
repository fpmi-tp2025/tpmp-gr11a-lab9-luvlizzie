//
//  Poet.swift
//  BelarusianPoets
//
//  Created by Кудинова Елизавета on 10.05.2026.
//  Группа 12, вариант 11
//

import UIKit

struct Poet: Codable {
    let id: Int
    let name: String
    let photoName: String
    let biography: String
    let works: [String]
    
    var photo: UIImage? {
        return UIImage(named: photoName)
    }
}
