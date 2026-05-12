//
//  PoetsCollectionViewController.swift
//  BelarusianPoets
//
//  Created by Кудинова Елизавета on 10.05.2026.
//  Группа 12, вариант 11 (индивидуальное задание)
//

import UIKit

class PoetsCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!

    private var poets: [Poet] = []
    private let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        loadPoets()
    }

    private func setupUI() {
        title = NSLocalizedString("poets_title", comment: "")
        view.backgroundColor = .systemBackground
        view.accessibilityIdentifier = "poetsScreen"
        
        navigationController?.navigationBar.accessibilityIdentifier = "poets_nav_bar"
        logoutButton.accessibilityIdentifier = "logoutButton"
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        // ФИКСИРОВАННАЯ ШИРИНА 150, ВЫСОТА 200
        layout.itemSize = CGSize(width: 150, height: 200)
        
        collectionView.collectionViewLayout = layout
    }

    private func loadPoets() {
        poets = PoetsDataManager.shared.loadPoets()
        collectionView.reloadData()
    }

    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        defaults.set(false, forKey: "isLoggedIn")
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension PoetsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return poets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PoetCell", for: indexPath) as! PoetCell
        let poet = poets[indexPath.row]
        cell.configure(with: poet)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PoetsCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poet = poets[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "PoetDetailViewController") as? PoetDetailViewController {
            detailVC.poet = poet
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
