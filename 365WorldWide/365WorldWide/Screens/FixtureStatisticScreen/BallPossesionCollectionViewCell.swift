//
//  BallPossesionCollectionViewCell.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class BallPossesionCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: BallPossesionCollectionViewCell.self)
    
    private let titleLabel: UILabel = {
         let label = UILabel()
          label.textAlignment = .center
          label.font = .systemFont(ofSize: 12, weight: .regular)
          label.text = "Ball Possession"
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          label.numberOfLines = 0
          return label
     }()
    
     let homeTeamStatLabel: UILabel = {
         let label = UILabel()
          label.textAlignment = .left
          label.font = .systemFont(ofSize: 14, weight: .regular)
          label.text = "5%"
          label.textColor = .mainYellowColor
          label.translatesAutoresizingMaskIntoConstraints = false
          label.numberOfLines = 0
          return label
     }()
    
     let awayTeamStatLabel: UILabel = {
         let label = UILabel()
          label.textAlignment = .right
          label.font = .systemFont(ofSize: 14, weight: .regular)
          label.text = "5%"
          label.textColor = .mainGreenColor
          label.translatesAutoresizingMaskIntoConstraints = false
          label.numberOfLines = 0
          return label
     }()
    
    let homeProgressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 53, height: 53), lineWidth: 4, rounded: true)
    let awayProgressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 53, height: 53), lineWidth: 4, rounded: true)
    
    let homeBallImageView = UIImageView()
    let awayBallImageView = UIImageView()
    
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
        addSubview(homeBallImageView)
        addSubview(awayBallImageView)
        
        homeBallImageView.image = UIImage(named: "ball")
        awayBallImageView.image = UIImage(named: "ball")

        homeProgressView.trackColor = UIColor(red: 0.1765, green: 0.2157, blue: 0.2667, alpha: 1.0)
        homeProgressView.progressColor = .mainYellowColor
        
        awayProgressView.trackColor = UIColor(red: 0.1765, green: 0.2157, blue: 0.2667, alpha: 1.0)
        awayProgressView.progressColor = .mainGreenColor
        
        homeProgressView.progress = 0.5
        awayProgressView.progress = 0.5
    }
    
    private func setUpConstraints() {
        homeProgressView.translatesAutoresizingMaskIntoConstraints = false
        awayProgressView.translatesAutoresizingMaskIntoConstraints = false
        homeBallImageView.translatesAutoresizingMaskIntoConstraints = false
        awayBallImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            homeTeamStatLabel.topAnchor.constraint(equalTo: homeProgressView.bottomAnchor, constant: 4),
            homeTeamStatLabel.centerXAnchor.constraint(equalTo: homeProgressView.centerXAnchor),
            
            awayTeamStatLabel.topAnchor.constraint(equalTo: awayProgressView.bottomAnchor, constant: 4),
            awayTeamStatLabel.centerXAnchor.constraint(equalTo: awayProgressView.centerXAnchor),
            
            homeProgressView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            homeProgressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            homeProgressView.heightAnchor.constraint(equalToConstant: 53),
            homeProgressView.widthAnchor.constraint(equalToConstant: 53),
            
            awayProgressView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            awayProgressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            awayProgressView.heightAnchor.constraint(equalToConstant: 53),
            awayProgressView.widthAnchor.constraint(equalToConstant: 53),
            
            homeBallImageView.centerXAnchor.constraint(equalTo: homeProgressView.centerXAnchor),
            homeBallImageView.centerYAnchor.constraint(equalTo: homeProgressView.centerYAnchor),
            homeBallImageView.heightAnchor.constraint(equalToConstant: 24),
            homeBallImageView.widthAnchor.constraint(equalToConstant: 24),
            
            awayBallImageView.centerXAnchor.constraint(equalTo: awayProgressView.centerXAnchor),
            awayBallImageView.centerYAnchor.constraint(equalTo: awayProgressView.centerYAnchor),
            awayBallImageView.heightAnchor.constraint(equalToConstant: 24),
            awayBallImageView.widthAnchor.constraint(equalToConstant: 24),
            
        ])
    }
    
    func configure(with viewModel: FixtureStatCellViewModel) {
        homeTeamStatLabel.text = viewModel.homeTeamValue
        awayTeamStatLabel.text = viewModel.awayTeamValue
        homeProgressView.progress = viewModel.progressHomeTeam
        awayProgressView.progress = viewModel.progressAwayTeam
    }
}
