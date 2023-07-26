//
//  LineUpHeaderCollectionReusableView.swift
//  365WorldWide
//
//  Created by MacBook on 26.07.2023.
//

import UIKit

class LineUpHeaderCollectionReusableView: UICollectionReusableView {
        
    static let reuseIdentifier = String(describing: LineUpHeaderCollectionReusableView.self)
    
    let homeTeamIconImageView = UIImageView()
    let awayTeamIconImageView = UIImageView()
   
    private let titleLabel: UILabel = {
         let label = UILabel()
          label.textAlignment = .center
          label.font = .systemFont(ofSize: 14, weight: .regular)
          label.text = "Start XI".uppercased()
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          label.numberOfLines = 0
          return label
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubview(homeTeamIconImageView)
        addSubview(awayTeamIconImageView)
        addSubview(titleLabel)
    }
    
    private func setUpConstraints() {
        homeTeamIconImageView.translatesAutoresizingMaskIntoConstraints = false
        awayTeamIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            homeTeamIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            homeTeamIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            homeTeamIconImageView.heightAnchor.constraint(equalToConstant: 20),
            homeTeamIconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            awayTeamIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            awayTeamIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            awayTeamIconImageView.heightAnchor.constraint(equalToConstant: 20),
            awayTeamIconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
