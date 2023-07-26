//
//  TeamView.swift
//  365WorldWide
//
//  Created by MacBook on 24.07.2023.
//

import UIKit

class TeamView: UIView {
    
    let teamImageView: UIImageView = {
     let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
     return imageView
    }()
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .center
         label.font = .systemFont(ofSize: 14, weight: .medium)
         label.text = "team name"
         label.textColor = .white
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         return label
    }()

    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubview(teamImageView)
        addSubview(teamNameLabel)
        
        NSLayoutConstraint.activate([
            teamImageView.heightAnchor.constraint(equalToConstant: 32),
            teamImageView.widthAnchor.constraint(equalToConstant: 32),
            teamImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            teamImageView.topAnchor.constraint(equalTo: topAnchor),
            
            teamNameLabel.topAnchor.constraint(equalTo: teamImageView.bottomAnchor, constant: 4),
            teamNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            teamNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
