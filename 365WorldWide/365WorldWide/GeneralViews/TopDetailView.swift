//
//  TopDetailView.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class TopDetailView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = UIColor(red: 0.1686, green: 0.3529, blue: 0.2863, alpha: 1.0)
    }

}
