//
//  FixtureEventsCollectionViewCell.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class FixtureEventsCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: FixtureEventsCollectionViewCell.self)
    
    let awayEventIconImageView = UIImageView()
    let homeEventIconImageView = UIImageView()
    let centerLine = UIView()
    
    let minuteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "84"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.backgroundColor = .mainGreenColor
        return label
    }()
    
    let homeTeamFirstEvent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "first event"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let homeTeamSecondEvent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "second event"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.5)
        return label
    }()
    
    let awayTeamFirstEvent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "first event"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let awayTeamSecondEvent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "second event"
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
        backgroundColor = .cellBGColor
        addSubview(minuteLabel)
        addSubview(awayEventIconImageView)
        addSubview(awayTeamFirstEvent)
        addSubview(awayTeamSecondEvent)
        addSubview(homeTeamFirstEvent)
        addSubview(homeEventIconImageView)
        addSubview(homeTeamSecondEvent)
        addSubview(centerLine)
        centerLine.backgroundColor = .white.withAlphaComponent(0.2)
        centerLine.translatesAutoresizingMaskIntoConstraints = false
        
        awayEventIconImageView.translatesAutoresizingMaskIntoConstraints = false
        homeEventIconImageView.translatesAutoresizingMaskIntoConstraints = false
        centerLine.translatesAutoresizingMaskIntoConstraints = false
        minuteLabel.layer.cornerRadius = 12
        minuteLabel.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            minuteLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            minuteLabel.topAnchor.constraint(equalTo: topAnchor),
            minuteLabel.heightAnchor.constraint(equalToConstant: 26),
            minuteLabel.widthAnchor.constraint(equalToConstant: 44),
            
            homeTeamFirstEvent.topAnchor.constraint(equalTo: topAnchor),
            homeTeamFirstEvent.trailingAnchor.constraint(equalTo: homeEventIconImageView.leadingAnchor, constant: -7),
            
            homeTeamSecondEvent.topAnchor.constraint(equalTo: homeTeamFirstEvent.bottomAnchor, constant: 4),
            homeTeamSecondEvent.trailingAnchor.constraint(equalTo: homeEventIconImageView.leadingAnchor, constant: -7),
            
            homeEventIconImageView.topAnchor.constraint(equalTo: topAnchor),
            homeEventIconImageView.trailingAnchor.constraint(equalTo: minuteLabel.leadingAnchor, constant: -12),
            homeEventIconImageView.heightAnchor.constraint(equalToConstant: 24),
            homeEventIconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            awayEventIconImageView.topAnchor.constraint(equalTo: topAnchor),
            awayEventIconImageView.leadingAnchor.constraint(equalTo: minuteLabel.trailingAnchor, constant: 12),
            awayEventIconImageView.heightAnchor.constraint(equalToConstant: 24),
            awayEventIconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            awayTeamFirstEvent.topAnchor.constraint(equalTo: topAnchor),
            awayTeamFirstEvent.leadingAnchor.constraint(equalTo: awayEventIconImageView.trailingAnchor, constant: 12),
            
            awayTeamSecondEvent.topAnchor.constraint(equalTo: awayTeamFirstEvent.bottomAnchor, constant: 4),
            awayTeamSecondEvent.leadingAnchor.constraint(equalTo: awayEventIconImageView.trailingAnchor, constant: 12),
            
            centerLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            centerLine.topAnchor.constraint(equalTo: minuteLabel.bottomAnchor),
            centerLine.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerLine.widthAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func configure(with viewModel: EventsCellViewModel) {
        minuteLabel.text = viewModel.homeTeamMinute ?? ""
        if viewModel.homeTeamMinute == "" {
            minuteLabel.text = viewModel.awayTeamMinute
        }
        homeEventIconImageView.image = viewModel.homeTeamEventIcon
        homeTeamFirstEvent.text = viewModel.homeTeamFirstEventName
        homeTeamSecondEvent.text = viewModel.homeTeamSecondEventName
       
        awayEventIconImageView.image = viewModel.awayTeamEventIcon
        awayTeamFirstEvent.text = viewModel.awayTeamFirstEventName
        awayTeamSecondEvent.text = viewModel.awayTeamSecondEventName
    }
}
            
