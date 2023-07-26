//
//  LineUpViewController.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class LineUpViewController: UIViewController {

    private let lineUpView = LineUpView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
         label.textColor = .white
         label.text = "Lineup"
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = lineUpView
        setUp()
    }
    
    private func setUp() {
        navigationController?.navigationBar.tintColor = .white.withAlphaComponent(0.5)
        navigationController?.navigationItem.backButtonTitle = "Detail"
        navigationItem.titleView = titleLabel
        
        lineUpView.collectionView.dataSource = self
        lineUpView.collectionView.delegate = self
    }
}
extension LineUpViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormationCollectionViewCell.reuseIdentifier, for: indexPath) as! FormationCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LineUpCollectionViewCell.reuseIdentifier, for: indexPath) as! LineUpCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 1{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LineUpHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! LineUpHeaderCollectionReusableView
            return header
        }
        return UICollectionReusableView()
    }
}
