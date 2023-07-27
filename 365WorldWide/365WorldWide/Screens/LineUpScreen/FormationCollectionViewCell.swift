//
//  FormationCollectionViewCell.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class FormationCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: FormationCollectionViewCell.self)
   
    let bgImage = UIImageView()
    let homeFormationImageView = UIImageView()
    let awayFormationImageView = UIImageView()
    let topConteinerView = UIView()
    let homeTeamIconImageView = UIImageView()
    let awayTeamIconImageView = UIImageView()
    let formationLabelStack = LabelsStackView()
    let codesLabelStack = LabelsStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        bgImage.image = UIImage(named: "lineUpBG")
        addSubview(bgImage)
        addSubview(homeFormationImageView)
        addSubview(awayFormationImageView)
        addSubview(topConteinerView)
        addSubview(homeTeamIconImageView)
        addSubview(awayTeamIconImageView)
        addSubview(formationLabelStack)
        addSubview(codesLabelStack)
        topConteinerView.backgroundColor = UIColor(red: 0.1686, green: 0.3529, blue: 0.2863, alpha: 0.5)
        topConteinerView.layer.cornerRadius = 4
        topConteinerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        formationLabelStack.leftLabel.font = .systemFont(ofSize: 13, weight: .medium)
        formationLabelStack.leftLabel.textColor = .mainYellowColor
        formationLabelStack.rightLabel.font = .systemFont(ofSize: 13, weight: .medium)
        formationLabelStack.rightLabel.textColor = .mainGreenColor
        formationLabelStack.leftLabel.text = "4-4-4"
        formationLabelStack.rightLabel.text = "44-4"
        
        codesLabelStack.leftLabel.font = .systemFont(ofSize: 14, weight: .medium)
        codesLabelStack.rightLabel.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    private func setUpConstraints() {
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        homeFormationImageView.translatesAutoresizingMaskIntoConstraints = false
        awayFormationImageView.translatesAutoresizingMaskIntoConstraints = false
        topConteinerView.translatesAutoresizingMaskIntoConstraints = false
        formationLabelStack.translatesAutoresizingMaskIntoConstraints = false
        homeTeamIconImageView.translatesAutoresizingMaskIntoConstraints = false
        awayTeamIconImageView.translatesAutoresizingMaskIntoConstraints = false
        codesLabelStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topConteinerView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            topConteinerView.heightAnchor.constraint(equalToConstant: 44),
            topConteinerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            topConteinerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            homeTeamIconImageView.leadingAnchor.constraint(equalTo: topConteinerView.leadingAnchor, constant: 8),
            homeTeamIconImageView.centerYAnchor.constraint(equalTo: topConteinerView.centerYAnchor, constant: 0),
            homeTeamIconImageView.heightAnchor.constraint(equalToConstant: 20),
            homeTeamIconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            codesLabelStack.centerYAnchor.constraint(equalTo: topConteinerView.centerYAnchor),
            codesLabelStack.leadingAnchor.constraint(equalTo: homeTeamIconImageView.trailingAnchor, constant: 8),
            codesLabelStack.trailingAnchor.constraint(equalTo: awayTeamIconImageView.leadingAnchor, constant: -8),
            
            awayTeamIconImageView.trailingAnchor.constraint(equalTo: topConteinerView.trailingAnchor, constant: -8),
            awayTeamIconImageView.centerYAnchor.constraint(equalTo: topConteinerView.centerYAnchor, constant: 0),
            awayTeamIconImageView.heightAnchor.constraint(equalToConstant: 20),
            awayTeamIconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            formationLabelStack.centerYAnchor.constraint(equalTo: topConteinerView.centerYAnchor),
            formationLabelStack.leadingAnchor.constraint(equalTo: homeTeamIconImageView.trailingAnchor, constant: 83),
            formationLabelStack.trailingAnchor.constraint(equalTo: awayTeamIconImageView.leadingAnchor, constant: -83),
            
            bgImage.topAnchor.constraint(equalTo: topConteinerView.bottomAnchor),
            bgImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            homeFormationImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            homeFormationImageView.widthAnchor.constraint(equalTo: bgImage.widthAnchor, multiplier: 0.49),
            homeFormationImageView.topAnchor.constraint(equalTo: bgImage.topAnchor),
            homeFormationImageView.bottomAnchor.constraint(equalTo: bgImage.bottomAnchor),
            
            awayFormationImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            awayFormationImageView.widthAnchor.constraint(equalTo: bgImage.widthAnchor, multiplier: 0.49),
            awayFormationImageView.topAnchor.constraint(equalTo: bgImage.topAnchor),
            awayFormationImageView.bottomAnchor.constraint(equalTo: bgImage.bottomAnchor),
        ])
    }
}
