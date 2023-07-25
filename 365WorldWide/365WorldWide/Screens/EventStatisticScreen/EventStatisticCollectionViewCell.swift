//
//  EventStatisticCollectionViewCell.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class EventStatisticCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: EventStatisticCollectionViewCell.self)
    
    private let titleLabel: UILabel = {
         let label = UILabel()
          label.textAlignment = .center
          label.font = .systemFont(ofSize: 12, weight: .regular)
          label.text = "Stat"
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          label.numberOfLines = 0
          return label
     }()
    
    private let homeTeamStatLabel: UILabel = {
         let label = UILabel()
          label.textAlignment = .left
          label.font = .systemFont(ofSize: 14, weight: .regular)
          label.text = "5%"
          label.textColor = .mainYellowColor
          label.translatesAutoresizingMaskIntoConstraints = false
          label.numberOfLines = 0
          return label
     }()
    
    private let awayTeamStatLabel: UILabel = {
         let label = UILabel()
          label.textAlignment = .right
          label.font = .systemFont(ofSize: 14, weight: .regular)
          label.text = "5%"
          label.textColor = .mainGreenColor
          label.translatesAutoresizingMaskIntoConstraints = false
          label.numberOfLines = 0
          return label
     }()
    
   let homeProgressView = UIProgressView()
    let awayProgressView = UIProgressView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = .cellBGColor
        addSubview(titleLabel)
        addSubview(homeTeamStatLabel)
        addSubview(awayTeamStatLabel)
        addSubview(homeProgressView)
        addSubview(awayProgressView)
       
        homeProgressView.trackTintColor = UIColor(red: 0.1765, green: 0.2157, blue: 0.2667, alpha: 1.0)
        homeProgressView.progressTintColor = .mainYellowColor
        homeProgressView.layer.cornerRadius = 6
        homeProgressView.semanticContentAttribute = .forceRightToLeft
        
        awayProgressView.trackTintColor = UIColor(red: 0.1765, green: 0.2157, blue: 0.2667, alpha: 1.0)
        awayProgressView.progressTintColor = .mainGreenColor
        awayProgressView.layer.cornerRadius = 6
        
        homeProgressView.progress = 0.5
        awayProgressView.progress = 0.5
    }
    
    private func setUpConstraints() {
        homeProgressView.translatesAutoresizingMaskIntoConstraints = false
        awayProgressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            homeTeamStatLabel.topAnchor.constraint(equalTo: topAnchor),
            homeTeamStatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            awayTeamStatLabel.topAnchor.constraint(equalTo: topAnchor),
            awayTeamStatLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            homeProgressView.heightAnchor.constraint(equalToConstant: 4),
            homeProgressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            homeProgressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            homeProgressView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -4),
            
            awayProgressView.heightAnchor.constraint(equalToConstant: 4),
            awayProgressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            awayProgressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            awayProgressView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 4),
        ])
    }
    
//    func configure(with viewModel: FixtureStatCellViewModel) {
//        titleLabel.text = viewModel.type
//        homeTeamStatLabel.text = viewModel.homeTeamValue
//        awayTeamStatLabel.text = viewModel.awayTeamValue
//        progressView.progress = viewModel.progressHomeTeam
//    }
}

