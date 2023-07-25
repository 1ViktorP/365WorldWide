//
//  FixtureCollectionViewCell.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class FixtureCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: FixtureCollectionViewCell.self)
    
    let conteinerView = FixtureView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubview(conteinerView)
        conteinerView.addEdgesConstraints(from: self)
    }
}
