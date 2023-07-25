//
//  StandingsViewController.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class StandingsViewController: UIViewController {
    
    private let standingsView = StandingsView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
         label.textColor = .white
         label.text = "League Standings"
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = standingsView
        setUp()
    }
    
    private func setUp() {
        navigationController?.navigationBar.tintColor = .white.withAlphaComponent(0.5)
        navigationController?.navigationItem.backButtonTitle = "Detail"
        navigationItem.titleView = titleLabel
        
        standingsView.collectionView.dataSource = self
        standingsView.collectionView.delegate = self
    }
}
extension StandingsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StandingsCollectionViewCell.reuseIdentifier, for: indexPath) as! StandingsCollectionViewCell
        return cell
    }
    
    
}
