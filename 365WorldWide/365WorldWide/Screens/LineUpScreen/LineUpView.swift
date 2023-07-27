//
//  LineUpView.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class LineUpView: UIView {

    var collectionView: UICollectionView!
    
    let topBGView = TopDetailView()
   
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
        topBGView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topBGView.topAnchor.constraint(equalTo: topAnchor),
            topBGView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBGView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBGView.heightAnchor.constraint(equalToConstant: 153),
            
        ])
    }
    
    private func setUpCollectionView() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: generateLayout())
        self.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(LineUpCollectionViewCell.self, forCellWithReuseIdentifier: LineUpCollectionViewCell.reuseIdentifier)
        collectionView.register(FormationCollectionViewCell.self, forCellWithReuseIdentifier: FormationCollectionViewCell.reuseIdentifier)
        collectionView.register(LineUpHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LineUpHeaderCollectionReusableView.reuseIdentifier)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: topBGView.bottomAnchor, constant: 24)
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
            heightDimension: .absolute(28))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fullSizeItem])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(52))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func generateLayoutFirstSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let fullSizeItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(281))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fullSizeItem])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }

}
