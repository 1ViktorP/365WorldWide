//
//  CalendarCollectionViewCell.swift
//  SportUs
//
//  Created by MacBook on 08.06.2023.
//

import UIKit
import JTAppleCalendar

class CalendarCollectionViewCell: JTACDayCell {
    
    static let reuseIdentifier = String(describing: CalendarCollectionViewCell.self)
    private let conteinerView = UIView()
    
    var dateLabel : UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "date"
        dateLabel.font = .systemFont(ofSize: 20)
        dateLabel.textAlignment = .center
        dateLabel.textColor = .white
        return dateLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
               selectedCell()
            } else {
               unSelectedCell()
            }
        }
    }
    
    func selectedCell() {
        dateLabel.textColor = .white
        conteinerView.backgroundColor = .mainYellowColor
        conteinerView.layer.cornerRadius = 20
    }
    
    func unSelectedCell() {
        dateLabel.textColor = .white
        conteinerView.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func setUp() {
        dateLabel.textColor = .white
        conteinerView.backgroundColor = .clear
        addSubview(conteinerView)
        addSubview(dateLabel)
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     dateLabel.heightAnchor.constraint(equalToConstant: 40),
                                     dateLabel.widthAnchor.constraint(equalToConstant: 40),
                                     
                                     conteinerView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     conteinerView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     conteinerView.heightAnchor.constraint(equalToConstant: 40),
                                     conteinerView.widthAnchor.constraint(equalToConstant: 40),
                                    ])
    }
}
