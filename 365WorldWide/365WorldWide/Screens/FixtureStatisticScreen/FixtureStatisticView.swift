//
//  EventStatisticView.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class FixtureStatisticView: UIView {

    var collectionView: UICollectionView!
    
    let topBGView = TopDetailView()
    let conteinerView = UIView()
    let labelsStack = LabelsStackView()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.backgroundColor = .mainBGColor
        addSubview(topBGView)
        addSubview(conteinerView)
        conteinerView.addSubview(labelsStack)
        conteinerView.backgroundColor = UIColor(red: 0.1686, green: 0.3529, blue: 0.2863, alpha: 0.5)
        conteinerView.layer.cornerRadius = 4
        conteinerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        topBGView.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.addEdgesConstraints(from: conteinerView)
        labelsStack.leftLabel.font = .systemFont(ofSize: 17, weight: .medium)
        labelsStack.rightLabel.font = .systemFont(ofSize: 17, weight: .medium)
        
        NSLayoutConstraint.activate([
            topBGView.topAnchor.constraint(equalTo: topAnchor),
            topBGView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBGView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBGView.heightAnchor.constraint(equalToConstant: 153),
            
            conteinerView.topAnchor.constraint(equalTo: topBGView.bottomAnchor, constant: 32),
            conteinerView.heightAnchor.constraint(equalToConstant: 44),
            conteinerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            conteinerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
        ])
    }
    
    private func setUpCollectionView() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: generateLayout())
        self.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(EventStatisticCollectionViewCell.self, forCellWithReuseIdentifier: EventStatisticCollectionViewCell.reuseIdentifier)
        collectionView.register(BallPossesionCollectionViewCell.self, forCellWithReuseIdentifier: BallPossesionCollectionViewCell.reuseIdentifier)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: 0)
        ])
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout (sectionProvider: { (sectionIndex: Int,
                                                                              layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                return self.generateLayoutFirstSection()
            } else {
                return self.generateLayoutSection()
            }
        })
        return layout
    }
    
    private func generateLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let fullSizeItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(58))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fullSizeItem])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    private func generateLayoutFirstSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let fullSizeItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(122))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fullSizeItem])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }
}
