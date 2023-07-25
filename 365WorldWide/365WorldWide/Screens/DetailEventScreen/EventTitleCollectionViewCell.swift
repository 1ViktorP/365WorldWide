//
//  EventTitleCollectionViewCell.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class EventTitleCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: EventTitleCollectionViewCell.self)
    let titleLabel: UILabel = {
    let label = UILabel()
     label.translatesAutoresizingMaskIntoConstraints = false
     label.textAlignment = .center
     label.text = ""
     label.font = .systemFont(ofSize: 17, weight: .medium)
     label.textColor = .white
     return label
 }()
    
    let disclosureIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")?.withTintColor(UIColor(red: 1, green: 0.8824, blue: 0.2745, alpha: 1.0), renderingMode: .alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = .cellBGColor
        addSubview(titleLabel)
        addSubview(disclosureIcon)
        layer.cornerRadius = 4
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            disclosureIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            disclosureIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ])
    }
}
