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
    var favoriteButtonHandler: (UIButton)-> Void = {_ in }
    
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
        conteinerView.minuteLabel.layer.cornerRadius = 5
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        favoriteButtonHandler(conteinerView.saveButton)
    }
    
    func configure(with viewModel: FixtureCellViewModel) {
        conteinerView.homeTeamView.teamNameLabel.text = viewModel.homeTeamName
        conteinerView.homeTeamView.teamImageView.kf.setImage(with: viewModel.homeTeamIcon)
        conteinerView.awayTeamView.teamNameLabel.text = viewModel.awayTeamName
        conteinerView.awayTeamView.teamImageView.kf.setImage(with: viewModel.awayTeamIcon)
        conteinerView.statusLabel.text = viewModel.status
        var city = viewModel.city
        if let dotRange = city.range(of: ",") {
            city.removeSubrange(dotRange.lowerBound..<city.endIndex)
        }
        
        conteinerView.placeLabel.text = city + "," + viewModel.country
        if viewModel.isFavorite {
            conteinerView.saveButton.setImage(UIImage(systemName: "star.fill")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            conteinerView.saveButton.setImage(UIImage(systemName: "star")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal), for: .normal)
        }
        
        if viewModel.status == "1H" || viewModel.status == "HT" || viewModel.status == "2H" ||  viewModel.status == "ET" ||
            viewModel.status == "BT" ||  viewModel.status == "P" {
            conteinerView.dateLabel.isHidden = true
            conteinerView.minuteLabel.isHidden = false
            conteinerView.minuteLabel.text = viewModel.minute + "'"
            conteinerView.timeScoreLabel.text = viewModel.homeTeamScore + " - " + viewModel.awayTeamScore
        } else if viewModel.status == "FT" {
            conteinerView.timeScoreLabel.text = viewModel.homeTeamScore + " - " + viewModel.awayTeamScore
            conteinerView.minuteLabel.isHidden = true
            conteinerView.dateLabel.isHidden = false
            conteinerView.dateLabel.text = Date.formatDateForCell(date: viewModel.date)
        } else {
            conteinerView.timeScoreLabel.text =  Date.formatHours(date: viewModel.date)
            conteinerView.minuteLabel.isHidden = true
        }
    }
}
