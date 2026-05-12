//
//  PoetDetailViewController.swift
//  BelarusianPoets
//
//  Created by Кудинова Елизавета on 10.05.2026.
//  Группа 12, вариант 11 (индивидуальное задание)
//

import UIKit

class PoetDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var biographyTextView: UITextView!
    @IBOutlet weak var worksTableView: UITableView!
    
    // MARK: - Properties
    var poet: Poet?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        guard let poet = poet else { return }
        
        title = poet.name
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.accessibilityIdentifier = "detail_nav_bar"
        
        nameLabel.text = poet.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.textAlignment = .center
        
        photoImageView.image = poet.photo
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.cornerRadius = 12
        photoImageView.clipsToBounds = true
        
        biographyTextView.text = poet.biography
        biographyTextView.font = UIFont.systemFont(ofSize: 16)
        biographyTextView.isEditable = false
        biographyTextView.isScrollEnabled = false
        
        worksTableView.dataSource = self
        worksTableView.delegate = self
        worksTableView.register(UITableViewCell.self, forCellReuseIdentifier: "WorkCell")
        worksTableView.isScrollEnabled = false
        worksTableView.reloadData()
        
        // Высота таблицы под контент
        worksTableView.heightAnchor.constraint(equalToConstant: CGFloat(poet.works.count * 44)).isActive = true
        
        nameLabel.accessibilityIdentifier = "nameLabel"
    }
}

// MARK: - UITableViewDataSource
extension PoetDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poet?.works.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkCell", for: indexPath)
        cell.textLabel?.text = poet?.works[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PoetDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
