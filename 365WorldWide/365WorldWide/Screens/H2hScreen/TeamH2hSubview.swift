//
//  TeamH2hSubview.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class TeamH2hSubview: UIView {

    let teamIconImageView = UIImageView()
    let teamNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "name"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        return label
    }()
   
    let scoreLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = "1"
        label.font = .systemFont(ofSize: 16, weight: .medium)
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
        addSubview(scoreLabel)
        addSubview(teamIconImageView)
        addSubview(teamNameLabel)
        
        teamIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            teamIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            teamIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            teamIconImageView.heightAnchor.constraint(equalToConstant: 24),
            teamIconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            teamNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            teamNameLabel.leadingAnchor.constraint(equalTo: teamIconImageView.trailingAnchor, constant: 4),
            teamNameLabel.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor, constant: -10),
            
            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
