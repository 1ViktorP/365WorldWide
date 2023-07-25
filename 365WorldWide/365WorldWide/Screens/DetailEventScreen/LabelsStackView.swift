//
//  LabelsStackView.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class LabelsStackView: UIView {

    let leftLabel: UILabel = {
    let label = UILabel()
     label.translatesAutoresizingMaskIntoConstraints = false
     label.textAlignment = .left
     label.text = ""
     label.font = .systemFont(ofSize: 12, weight: .medium)
     label.textColor = .white
     return label
 }()
    
    let rightLabel: UILabel = {
    let label = UILabel()
     label.translatesAutoresizingMaskIntoConstraints = false
     label.textAlignment = .right
     label.text = ""
     label.font = .systemFont(ofSize: 12, weight: .semibold)
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
        let stack = UIStackView(arrangedSubviews: [leftLabel, rightLabel])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.addEdgesConstraints(from: self)
    }
}
