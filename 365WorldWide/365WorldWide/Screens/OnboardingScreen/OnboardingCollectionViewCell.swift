//
//  OnboardingCollectionViewCell.swift
//  BetCounter
//
//  Created by MacBook on 27.04.2023.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: OnboardingCollectionViewCell.self)
    
     var bgImageView = UIImageView()
    var smallBGImageView = UIImageView()
    var smallBG2ImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = .clear
        addSubview(bgImageView)
        addSubview(smallBGImageView)
        addSubview(smallBG2ImageView)
        bgImageView.contentMode = .scaleAspectFit
        smallBGImageView.image = UIImage(named: "onBoard1small")
        smallBG2ImageView.image = UIImage(named: "onBoard2small")
        smallBG2ImageView.isHidden = true
        smallBGImageView.layer.cornerRadius = 4
        smallBG2ImageView.layer.cornerRadius = 4
        smallBGImageView.clipsToBounds = true
        smallBG2ImageView.clipsToBounds = true
    }
    
    private func setUpConstraints() {
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        smallBGImageView.translatesAutoresizingMaskIntoConstraints = false
        smallBG2ImageView.translatesAutoresizingMaskIntoConstraints = false
               
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            bgImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            bgImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            bgImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            smallBGImageView.topAnchor.constraint(equalTo: topAnchor ,constant:  42),
            smallBGImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            smallBGImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            smallBGImageView.heightAnchor.constraint(equalToConstant: 109),
            
            smallBG2ImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            smallBG2ImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            smallBG2ImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            smallBG2ImageView.heightAnchor.constraint(equalToConstant: 109),
        ])
    }
}
