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
    
    
//    let dateLabel: UILabel = {
//        let label = UILabel()
//         label.textAlignment = .left
//         label.font = .systemFont(ofSize: 15)
//         label.text = "team name"
//         label.textColor = .textColor
//         label.translatesAutoresizingMaskIntoConstraints = false
//         label.numberOfLines = 0
//         return label
//    }()
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
        starImageView.image = UIImage(systemName: "star")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal)
        conteinerPlaceView.backgroundColor = UIColor(red: 0.2196, green: 0.4824, blue: 0.3373, alpha: 1.0)
        conteinerPlaceView.layer.cornerRadius = 20
        conteinerPlaceView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    private func setUpConstraints() {
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        conteinerPlaceView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            starImageView.heightAnchor.constraint(equalToConstant: 24),
            starImageView.widthAnchor.constraint(equalToConstant: 24),
            starImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            starImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            conteinerPlaceView.heightAnchor.constraint(equalToConstant: 15),
            conteinerPlaceView.widthAnchor.constraint(equalToConstant: 130),
            conteinerPlaceView.topAnchor.constraint(equalTo: topAnchor),
            conteinerPlaceView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            statusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
        ])
    }
    
}
