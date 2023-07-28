//
//  SavedView.swift
//  365WorldWide
//
//  Created by MacBook on 28.07.2023.
//

import UIKit

class SavedView: UIView {

    var fixturesCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setUpMathesCollectionView()
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = .mainBGColor
    }
    
    private func setUpMathesCollectionView() {
        fixturesCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: generateLayoutMatchesCollection())
        self.addSubview(fixturesCollectionView)
        fixturesCollectionView.backgroundColor = .clear
        fixturesCollectionView.showsVerticalScrollIndicator = false
        fixturesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        fixturesCollectionView.register(FixtureCollectionViewCell.self, forCellWithReuseIdentifier: FixtureCollectionViewCell.reuseIdentifier)
    }
    
    private func setUpConstrains() {
        
        NSLayoutConstraint.activate([
            fixturesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            fixturesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            fixturesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            fixturesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24)
        ])
    }
    
    private func generateLayoutMatchesCollection() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout (sectionProvider: { (sectionIndex: Int,
                                                                              layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            return self.generateLayoutMatchesSection()
        })
        return layout
    }
  
    private func generateLayoutMatchesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let fullSizeItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullSizeItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(141))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fullSizeItem])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }
}
