//
//  TopDetailView.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class TopDetailView: UIView {
    
    let homeTeamIcon = UIImageView()
    let awayTeamIcon = UIImageView()
    
    let homeTeamNameLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .center
         label.font = .systemFont(ofSize: 22, weight: .medium)
         label.text = "team name"
         label.textColor = .mainYellowColor
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         return label
    }()
    
    let awayTeamNameLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .center
         label.font = .systemFont(ofSize: 22, weight: .medium)
         label.text = "team name"
         label.textColor = .mainGreenColor
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .center
         label.font = .systemFont(ofSize: 24, weight: .medium)
         label.text = "team name"
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
        backgroundColor = UIColor(red: 0.1686, green: 0.3529, blue: 0.2863, alpha: 1.0)
        addSubview(homeTeamIcon)
        addSubview(homeTeamNameLabel)
        addSubview(scoreLabel)
        addSubview(awayTeamIcon)
       addSubview(awayTeamNameLabel)
        
        homeTeamIcon.translatesAutoresizingMaskIntoConstraints = false
        awayTeamIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            homeTeamIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            homeTeamIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            homeTeamIcon.heightAnchor.constraint(equalToConstant: 32),
            homeTeamIcon.widthAnchor.constraint(equalToConstant: 32),
           
            homeTeamNameLabel.centerYAnchor.constraint(equalTo: homeTeamIcon.centerYAnchor),
            homeTeamNameLabel.leadingAnchor.constraint(equalTo: homeTeamIcon.trailingAnchor, constant: 8),
            
            scoreLabel.centerYAnchor.constraint(equalTo: homeTeamIcon.centerYAnchor),
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            awayTeamIcon.leadingAnchor.constraint(equalTo: scoreLabel.trailingAnchor, constant: 30),
            awayTeamIcon.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor, constant: 0),
            awayTeamIcon.heightAnchor.constraint(equalToConstant: 32),
            awayTeamIcon.widthAnchor.constraint(equalToConstant: 32),

            awayTeamNameLabel.centerYAnchor.constraint(equalTo: awayTeamIcon.centerYAnchor),
            awayTeamNameLabel.leadingAnchor.constraint(equalTo: awayTeamIcon.trailingAnchor, constant: 8),
        ])
        
    }
    
    func configure(with fixture: FixtureCellViewModel, codes: TeamCodeViewModel) {
        homeTeamNameLabel.text = codes.homeTeamCode
        homeTeamIcon.kf.setImage(with: fixture.homeTeamIcon)
        awayTeamNameLabel.text = codes.awayTeamCode
        awayTeamIcon.kf.setImage(with: fixture.awayTeamIcon)
        
        if fixture.status == "1H" || fixture.status == "HT" || fixture.status == "2H" ||  fixture.status == "ET" ||
            fixture.status == "BT" ||  fixture.status == "P" || fixture.status == "FT" {
            scoreLabel.text = fixture.homeTeamScore + " - " + fixture.awayTeamScore
        } else {
            scoreLabel.text = "- : -"
        }
    }
}
