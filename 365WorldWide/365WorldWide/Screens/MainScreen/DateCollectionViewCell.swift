//
//  DateCollectionViewCell.swift
//  365WorldWide
//
//  Created by MacBook on 24.07.2023.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: DateCollectionViewCell.self)
    
    let dateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "15"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let dayLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "m"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.5)
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
        let stack = UIStackView(arrangedSubviews: [dateLabel, dayLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setUpiSSelected()
            } else {
                setUpIsUnselected()
            }
        }
    }
    
    func setUpIsUnselected() {
        self.backgroundColor = .clear
    }
    
    func setUpiSSelected() {
        self.backgroundColor = .mainYellowColor
        self.layer.cornerRadius = 14
    }
}
