//
//  DetailEventView.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class DetailEventView: UIView {

    var topImageView = UIImageView()
    let fixtureView = FixtureView()
    var collectionView: UICollectionView!
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Explore event details"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let leagueLabelStack = LabelsStackView()
    let dateLabelStack = LabelsStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setUpCollectionView()
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubview(topImageView)
        addSubview(titleLabel)
        addSubview(fixtureView)
        backgroundColor = .mainBGColor
        topImageView.image = UIImage(named: "eventBGImage")
        fixtureView.conteinerPlaceView.backgroundColor = .clear
        fixtureView.backgroundColor = .clear
        fixtureView.saveButton.isHidden = true
        fixtureView.statusLabel.isHidden = true
        leagueLabelStack.leftLabel.text = "League: "
        dateLabelStack.leftLabel.text = "Date: "
    }
    
    
    private func setUpCollectionView() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: generateLayout())
        self.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(EventTitleCollectionViewCell.self, forCellWithReuseIdentifier: EventTitleCollectionViewCell.reuseIdentifier)
    }
    
    private func setUpConstrains() {
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        fixtureView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelsStack = UIStackView(arrangedSubviews: [leagueLabelStack, dateLabelStack])
        labelsStack.axis = .vertical
        labelsStack.distribution = .fillEqually
        labelsStack.spacing = 8
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelsStack)
        fixtureView.backgroundColor = .clear
        var topLabelAnchor: CGFloat = 41
        var topFixtureAnchor: CGFloat = 0

        if SceneDelegate.deviceHeight < 812 {
            topLabelAnchor = 16
            topFixtureAnchor = -41
        }
        
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo: topAnchor),
            topImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.39),
            
            fixtureView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: topFixtureAnchor),
            fixtureView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fixtureView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fixtureView.heightAnchor.constraint(equalToConstant: 114),
            
            labelsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            labelsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            labelsStack.topAnchor.constraint(equalTo: fixtureView.bottomAnchor, constant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: topLabelAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24)
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
            heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fullSizeItem])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }
}
