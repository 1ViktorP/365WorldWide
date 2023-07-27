//
//  StandingsViewController.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class StandingsViewController: UIViewController {
    
    private let standingsView = StandingsView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
         label.textColor = .white
         label.text = "League Standings"
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    private var activityIndicator: UIActivityIndicatorView = {
       let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private var viewModel: StandingsViewModel!
    private var teamCodes: TeamCodeViewModel!
    
    init(fixture: FixtureCellViewModel, codes: TeamCodeViewModel) {
        viewModel = StandingsViewModel(fixture: fixture)
        teamCodes = codes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = standingsView
        setUp()
        activityIndicator.startAnimating()
    }
    
    private func setUp() {
        navigationController?.navigationBar.tintColor = .white.withAlphaComponent(0.5)
        navigationController?.navigationItem.backButtonTitle = "Detail"
        navigationItem.titleView = titleLabel
        
        standingsView.collectionView.dataSource = self
        standingsView.collectionView.delegate = self
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        viewModel.reloadData = { isAvailable in
            if isAvailable {
                self.activityIndicator.stopAnimating()
                self.standingsView.collectionView.reloadData()
                self.standingsView.leageNameLabel.text = self.viewModel.leagueName
            } else {
                //add missing data label
            }
        }
        standingsView.topBGView.configure(with: viewModel.fixture, codes: teamCodes)
    }
}
extension StandingsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.standingsList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StandingsCollectionViewCell.reuseIdentifier, for: indexPath) as! StandingsCollectionViewCell
        if indexPath.row == 0 {
            cell.numberlabel.text = "#"
            cell.numberlabel.font = .systemFont(ofSize: 14, weight: .medium)
            cell.teamNameLabel.text = "Name of Team"
            cell.teamNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
            cell.pLabel.font = .systemFont(ofSize: 14, weight: .medium)
            cell.pLabel.textColor = .mainYellowColor
            cell.gdLabel.font = .systemFont(ofSize: 14, weight: .medium)
            cell.gdLabel.textColor = .mainYellowColor
            cell.ptsLabel.font = .systemFont(ofSize: 14, weight: .medium)
            cell.ptsLabel.textColor = .mainYellowColor
        } else {
            cell.configure(with: viewModel.standingsList[indexPath.row - 1])
        }
        return cell
    }
    
    
}
