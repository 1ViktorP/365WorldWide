//
//  H2hView.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class H2hView: UIView {

    var collectionView: UICollectionView!
    
    private let topBGView = TopDetailView()
    var conteinerView = UIView()
    
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
        conteinerView.backgroundColor = UIColor(red: 0.1686, green: 0.3529, blue: 0.2863, alpha: 0.5)
        conteinerView.layer.cornerRadius = 4
        conteinerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        topBGView.translatesAutoresizingMaskIntoConstraints = false
        
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
        collectionView.register(H2hCollectionViewCell.self, forCellWithReuseIdentifier: H2hCollectionViewCell.reuseIdentifier)
        
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
            return self.generateLayoutSection()
        })
        return layout
    }
    
    private func generateLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let fullSizeItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullSizeItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(72))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fullSizeItem])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }
}
