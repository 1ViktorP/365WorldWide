//
//  StandingsCollectionViewCell.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class StandingsCollectionViewCell: UICollectionViewCell {
 
    static let reuseIdentifier = String(describing: StandingsCollectionViewCell.self)
    
    let imageView = UIImageView()
    let teamIconImageView = UIImageView()
    let bottomLine = UIView()
    
    let numberlabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "1"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let teamNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "name"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
   
    let pLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "1"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let gdLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "1"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let ptsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "1"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
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
        backgroundColor = .cellBGColor
        addSubview(imageView)
        addSubview(numberlabel)
        addSubview(teamIconImageView)
        addSubview(teamNameLabel)
        addSubview(bottomLine)
        bottomLine.backgroundColor = .white.withAlphaComponent(0.2)
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        teamIconImageView.translatesAutoresizingMaskIntoConstraints = false
        let stack = UIStackView(arrangedSubviews: [pLabel, gdLabel, ptsLabel])
        stack.axis = .horizontal
        stack.spacing = 2
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            ptsLabel.widthAnchor.constraint(equalToConstant: 20),
            
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            numberlabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberlabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            numberlabel.widthAnchor.constraint(equalToConstant: 16),
            
            teamIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            teamIconImageView.leadingAnchor.constraint(equalTo: numberlabel.trailingAnchor, constant: 10),
            teamIconImageView.heightAnchor.constraint(equalToConstant: 24),
            teamIconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            teamNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            teamNameLabel.leadingAnchor.constraint(equalTo: teamIconImageView.trailingAnchor, constant: 4),
            teamNameLabel.trailingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -10),
            
            bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomLine.leadingAnchor.constraint(equalTo: teamNameLabel.leadingAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}
