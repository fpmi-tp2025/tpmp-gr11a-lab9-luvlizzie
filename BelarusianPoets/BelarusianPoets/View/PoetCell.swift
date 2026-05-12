//
//  PoetCell.swift
//  BelarusianPoets
//
//  Created by Кудинова Елизавета on 10.05.2026.
//  Группа 12, вариант 11
//

import UIKit

class PoetCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with poet: Poet) {
        nameLabel.text = poet.name
        imageView.image = poet.photo ?? UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFill   
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
    }
}
