//
//  OnboardingView.swift
//  BetCounter
//
//  Created by MacBook on 27.04.2023.
//

import UIKit

final class OnboardingView: UIView {
    
    var collectionView: UICollectionView!
    var startButton = UIButton()
    var rowHandler: ((Int)->Void) = {_ in}
    var bottomView = UIView()
    let bgImageView = UIImageView()
    let skipButton = UIButton()
   
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .mainYellowColor
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let subTitleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setUpConstraints()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    func setUp() {
        insertSubview(bgImageView, at: 0)
        addSubview(bottomView)
        addSubview(startButton)
        addSubview(skipButton)
        startButton.setTitle("Next", for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        startButton.backgroundColor = .mainYellowColor
        startButton.layer.cornerRadius = 16
        startButton.setTitleColor(.black, for: .normal)
        skipButton.setTitle("skip", for: .normal)
        skipButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        skipButton.setImage(UIImage(systemName: "chevron.right")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        skipButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        skipButton.semanticContentAttribute = .forceRightToLeft
        bottomView.backgroundColor = .cellBGColor
        bottomView.layer.cornerRadius = 15
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bgImageView.image = UIImage(named: "onBoardBG")       
    }
    
    func setUpConstraints() {
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        
        let labelStack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        labelStack.spacing = 12
        labelStack.axis = .vertical
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelStack)

        
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: topAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bottomView.heightAnchor.constraint(equalToConstant: 232),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            startButton.widthAnchor.constraint(equalToConstant: 243),
            startButton.heightAnchor.constraint(equalToConstant: 45),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            labelStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelStack.widthAnchor.constraint(equalToConstant: 300),
            labelStack.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 24),
            
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            skipButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
        ])
    }
    
    func setUpCollectionView() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: generateLayout())
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier)
        insertSubview(collectionView, belowSubview: bottomView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            collectionView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 80),
        ])
    }
        
        func generateLayout() -> UICollectionViewLayout {
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
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fullSizeItem])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                setUpCellSwipe(section: section)
                return section
            }
    
    private func setUpCellSwipe(section: NSCollectionLayoutSection) {
        section.visibleItemsInvalidationHandler = { [weak self] visibleItems, point, environment in
            guard let self = self else { return }
        let currentIndex = visibleItems.last?.indexPath.row
            switch currentIndex {
            case 0:
                self.rowHandler(0)
                self.startButton.setTitle("Next", for: .normal)
            case 1:
                self.rowHandler(1)
                self.startButton.setTitle("Next", for: .normal)
            case 2:
                self.rowHandler(2)
                self.startButton.setTitle("Start", for: .normal)
            default: break
            }
        }
    }
}
