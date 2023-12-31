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
    var calendarButton = UIButton()
    
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
        addSubview(calendarButton)
        calendarButton.setImage(UIImage(named: "calendarIcon"), for: .normal)
        calendarButton.translatesAutoresizingMaskIntoConstraints = false
        calendarButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        calendarButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        calendarButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        calendarButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
    }
    
    private func setUpCollectionView() {
        dateCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: generateLayout())
        self.addSubview(dateCollectionView)
        dateCollectionView.isScrollEnabled = false
        dateCollectionView.clipsToBounds = true
        dateCollectionView.backgroundColor = .clear
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
            
            dateCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            dateCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -95),
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
            widthDimension: .absolute(64),
            heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fullSizeItem])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
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
