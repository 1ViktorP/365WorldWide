//
//  LineUpCollectionViewCell.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class LineUpCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: LineUpCollectionViewCell.self)
    
    let labelsView = LabelsStackView()
    private let homeTeamPositionLabel: UILabel = {
         let label = UILabel()
          label.textAlignment = .center
          label.font = .systemFont(ofSize: 10, weight: .regular)
          label.text = "GOA"
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          label.numberOfLines = 0
          return label
     }()
    
    private let awayTeamPositionLabel: UILabel = {
         let label = UILabel()
          label.textAlignment = .center
          label.font = .systemFont(ofSize: 10, weight: .regular)
          label.text = "GOA"
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          label.numberOfLines = 0
          return label
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubview(labelsView)
        labelsView.leftLabel.font = .systemFont(ofSize: 12, weight: .regular)
        labelsView.rightLabel.font = .systemFont(ofSize: 12, weight: .regular)
        homeTeamPositionLabel.layer.cornerRadius = 12
        awayTeamPositionLabel.layer.cornerRadius = 12
        
        let positionStack = UIStackView(arrangedSubviews: [homeTeamPositionLabel, awayTeamPositionLabel])
        positionStack.axis = .horizontal
        positionStack.spacing = 12
        positionStack.distribution = .fillEqually
        positionStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(positionStack)
        
        labelsView.addEdgesConstraints(from: self)
        positionStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        positionStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        homeTeamPositionLabel.widthAnchor.constraint(equalToConstant: 28).isActive = true
        homeTeamPositionLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
    }
}
