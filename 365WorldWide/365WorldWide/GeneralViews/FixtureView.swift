//
//  FixtureView.swift
//  SportUs
//
//  Created by MacBook on 07.06.2023.
//

import UIKit

class FixtureView: UIView {

   let homeTeamView = TeamView()
   let awayTeamView = TeamView()
   let starImageView = UIImageView()
    let conteinerPlaceView = UIView()
    let geoIconImageView = UIImageView()

    let placeLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .center
         label.font = .systemFont(ofSize: 10)
         label.text = "place"
         label.textColor = .white
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         return label
    }()
    
    let timeScoreLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .center
         label.font = .systemFont(ofSize: 24, weight: .semibold)
         label.text = ""
         label.textColor = .white
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         return label
    }()
    
    let minuteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.text = ""
        label.textColor = .white.withAlphaComponent(0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 0.1765, green: 0.2157, blue: 0.2706, alpha: 1.0) 
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .regular)
         label.text = ""
         label.textColor = .white.withAlphaComponent(0.5)
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         return label
    }()
//
    let statusLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .center
         label.font = .systemFont(ofSize: 10)
         label.text = "FT"
         label.textColor = .white
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         return label
    }()
    
    init() {
        super.init(frame: .zero)
        setUp()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.backgroundColor = .cellBGColor
        addSubview(starImageView)
        addSubview(conteinerPlaceView)
        addSubview(statusLabel)
        addSubview(timeScoreLabel)
        addSubview(dateLabel)
        addSubview(homeTeamView)
        addSubview(awayTeamView)
        addSubview(minuteLabel)
        starImageView.image = UIImage(systemName: "star")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal)
        conteinerPlaceView.backgroundColor = UIColor(red: 0.2196, green: 0.4824, blue: 0.3373, alpha: 1.0)
        conteinerPlaceView.layer.cornerRadius = 10
        conteinerPlaceView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        geoIconImageView.image = UIImage(named: "geoIcon")
        
        minuteLabel.isHidden = true
        minuteLabel.layer.cornerRadius = 5
    }
    
    private func setUpConstraints() {
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        conteinerPlaceView.translatesAutoresizingMaskIntoConstraints = false
        homeTeamView.translatesAutoresizingMaskIntoConstraints = false
        awayTeamView.translatesAutoresizingMaskIntoConstraints = false
        
        let placeStack = UIStackView(arrangedSubviews: [geoIconImageView, placeLabel])
        placeStack.axis = .horizontal
        placeStack.spacing = 4
        placeStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeStack)
        geoIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            starImageView.heightAnchor.constraint(equalToConstant: 24),
            starImageView.widthAnchor.constraint(equalToConstant: 24),
            starImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            starImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            conteinerPlaceView.heightAnchor.constraint(equalToConstant: 35),
            conteinerPlaceView.widthAnchor.constraint(equalToConstant: 130),
            conteinerPlaceView.topAnchor.constraint(equalTo: topAnchor, constant: -10),
            conteinerPlaceView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            placeStack.centerXAnchor.constraint(equalTo: conteinerPlaceView.centerXAnchor),
            placeStack.bottomAnchor.constraint(equalTo: conteinerPlaceView.bottomAnchor, constant: -4),
            
            geoIconImageView.heightAnchor.constraint(equalToConstant: 15),
            geoIconImageView.widthAnchor.constraint(equalToConstant: 15),
            
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            statusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            timeScoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeScoreLabel.topAnchor.constraint(equalTo: conteinerPlaceView.bottomAnchor, constant: 24),
            
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: timeScoreLabel.bottomAnchor),
            
            minuteLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            minuteLabel.topAnchor.constraint(equalTo: timeScoreLabel.bottomAnchor),
            minuteLabel.heightAnchor.constraint(equalToConstant: 23),
            minuteLabel.widthAnchor.constraint(equalToConstant: 51),
            
            homeTeamView.topAnchor.constraint(equalTo: conteinerPlaceView.bottomAnchor, constant: 16),
            homeTeamView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            homeTeamView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            homeTeamView.widthAnchor.constraint(equalToConstant: 116),
            
            awayTeamView.topAnchor.constraint(equalTo: conteinerPlaceView.bottomAnchor, constant: 16),
            awayTeamView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            awayTeamView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            awayTeamView.widthAnchor.constraint(equalToConstant: 116),
            
        ])
    }
    
}
