//
//  H2hCollectionViewCell.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class H2hCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: H2hCollectionViewCell.self)
    
    let bottomLine = UIView()
    let dateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "name \n date"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let homeTeamView = TeamH2hSubview()
    let awayTeamView = TeamH2hSubview()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUp() {
        backgroundColor = .cellBGColor
        addSubview(bottomLine)
        bottomLine.backgroundColor = .white.withAlphaComponent(0.2)
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [homeTeamView, awayTeamView])
        stack.axis = .vertical
        stack.spacing = 11
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.widthAnchor.constraint(equalToConstant: 45),
            
            stack.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomLine.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func configure(with viewModel: FixtureCellViewModel) {
        
        homeTeamView.teamNameLabel.text = viewModel.homeTeamName
        homeTeamView.teamIconImageView.kf.setImage(with: viewModel.homeTeamIcon)
        homeTeamView.scoreLabel.text = viewModel.homeTeamScore
        awayTeamView.teamNameLabel.text = viewModel.awayTeamName
        awayTeamView.teamIconImageView.kf.setImage(with: viewModel.awayTeamIcon)
        awayTeamView.scoreLabel.text = viewModel.awayTeamScore
        
    }
}
