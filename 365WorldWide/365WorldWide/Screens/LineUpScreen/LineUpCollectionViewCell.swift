//
//  LineUpCollectionViewCell.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class LineUpCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: LineUpCollectionViewCell.self)
    
    let labelsView = LabelsStackView()
    private let homeTeamPositionLabel: UILabel = {
         let label = UILabel()
          label.textAlignment = .center
          label.font = .systemFont(ofSize: 10, weight: .regular)
          label.text = "GOA"
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          label.numberOfLines = 0
          return label
     }()
    
    private let awayTeamPositionLabel: UILabel = {
         let label = UILabel()
          label.textAlignment = .center
          label.font = .systemFont(ofSize: 10, weight: .regular)
          label.text = "GOA"
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          label.numberOfLines = 0
          return label
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        homeTeamPositionLabel.layer.cornerRadius = 6
        homeTeamPositionLabel.clipsToBounds = true
        awayTeamPositionLabel.layer.cornerRadius = 6
        awayTeamPositionLabel.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubview(labelsView)
        labelsView.leftLabel.font = .systemFont(ofSize: 12, weight: .regular)
        labelsView.rightLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        let positionStack = UIStackView(arrangedSubviews: [homeTeamPositionLabel, awayTeamPositionLabel])
        positionStack.axis = .horizontal
        positionStack.spacing = 12
        positionStack.distribution = .fillEqually
        positionStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(positionStack)
        
        labelsView.addEdgesConstraints(from: self)
        positionStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        positionStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        homeTeamPositionLabel.widthAnchor.constraint(equalToConstant: 28).isActive = true
        homeTeamPositionLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    func configure(with viewModel: LineUpCellViewModel) {
        labelsView.leftLabel.text = viewModel.playerNameHomeTeam
        labelsView.rightLabel.text = viewModel.playerNameAwayTeam
        homeTeamPositionLabel.text = viewModel.playerPositioHomeTeam
        awayTeamPositionLabel.text = viewModel.playerPositioAwayTeam
        homeTeamPositionLabel.backgroundColor = getColor(pos: viewModel.playerPositioHomeTeam)
        awayTeamPositionLabel.backgroundColor = getColor(pos: viewModel.playerPositioAwayTeam)
    }
    
    func getColor(pos: String) -> UIColor {
        switch pos {
        case "G":
            return UIColor(red: 0.3569, green: 0.7333, blue: 0.5255, alpha: 1.0)
        case "D":
            return UIColor(red: 0.4549, green: 0.3569, blue: 0.7333, alpha: 1.0)
        case "M":
            return UIColor(red: 1, green: 0.8824, blue: 0.2745, alpha: 1.0)
        case "F":
            return UIColor(red: 0.898, green: 0.3059, blue: 0.2667, alpha: 1.0)
        default: return .white
        }
    }
}
