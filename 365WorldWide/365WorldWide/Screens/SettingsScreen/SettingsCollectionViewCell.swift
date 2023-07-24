//
//  SettingsCollectionViewCell.swift
//  YourLucky
//
//  Created by MacBook on 07.07.2023.
//

import UIKit

class SettingsCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: SettingsCollectionViewCell.self)
    
    var toogleHandler: (Bool) -> () = { _ in }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var switchButton: UISwitch!
    var disclosureIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "disclosureIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
   // var disclosureLine = UIView()
    var conteinerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        switchButton = UISwitch()
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.isHidden = true
        switchButton.tintColor = UIColor(red: 0.5647, green: 0.5647, blue: 0.5843, alpha: 0.6)
        switchButton.layer.cornerRadius = 16
        switchButton.clipsToBounds = true
        toogleHandler = { isOn in
            self.switchButton.isOn = isOn
        }
        conteinerView.addSubview(switchButton)
        conteinerView.addSubview(titleLabel)
        conteinerView.addSubview(disclosureIcon)
        conteinerView.backgroundColor = .cellBGColor
        conteinerView.layer.cornerRadius = 8
        self.addSubview(conteinerView)
        self.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            conteinerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  0),
            conteinerView.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.centerYAnchor.constraint(equalTo: conteinerView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.widthAnchor.constraint(equalToConstant: 180),
            
            disclosureIcon.centerYAnchor.constraint(equalTo: conteinerView.centerYAnchor),
            disclosureIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            disclosureIcon.heightAnchor.constraint(equalToConstant: 18),
            disclosureIcon.widthAnchor.constraint(equalToConstant: 14),
            
            switchButton.centerYAnchor.constraint(equalTo: conteinerView.centerYAnchor),
            switchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            switchButton.widthAnchor.constraint(equalToConstant: 51),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: 8),
        ])
    }
}
