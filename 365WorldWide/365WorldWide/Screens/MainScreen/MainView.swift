//
//  MainView.swift
//  365WorldWide
//
//  Created by MacBook on 24.07.2023.
//

import UIKit

class MainView: UIView {

    var dateCollectionView: UICollectionView!
    var fixturesCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setUpCollectionView()
        setUpMathesCollectionView()
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        dateCollectionView.layer.applySketchShadow(color: .black.withAlphaComponent(0.25), y: 4, blur: 4)
    }
    
    private func setUp() {
        backgroundColor = .mainBGColor
    }
    
    private func setUpCollectionView() {
        dateCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: generateLayout())
        self.addSubview(dateCollectionView)
        dateCollectionView.backgroundColor = UIColor(named: "mainBGColor")
        dateCollectionView.isScrollEnabled = false
        dateCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        dateCollectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.reuseIdentifier)
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
            
            dateCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dateCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dateCollectionView.heightAnchor.constraint(equalToConstant: 70),
            dateCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            
            fixturesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            fixturesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            fixturesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            fixturesCollectionView.topAnchor.constraint(equalTo: dateCollectionView.bottomAnchor, constant: 24)
        ])
    }
    
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout (sectionProvider: { (sectionIndex: Int,
                                                                              layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            return self.generateLayoutDateSection()
        })
        return layout
    }
    
    private func generateLayoutMatchesCollection() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout (sectionProvider: { (sectionIndex: Int,
                                                                              layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            return self.generateLayoutMatchesSection()
        })
        return layout
    }
    
    private func generateLayoutDateSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let fullSizeItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(54),
            heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fullSizeItem])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
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
