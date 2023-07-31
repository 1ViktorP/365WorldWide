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
    
    private var missingDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Dear user, no information on this event is available yet"
        label.font = .systemFont(ofSize: 19, weight: .light)
        label.textColor = .white.withAlphaComponent(0.5)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        view.addSubview(missingDataLabel)
        missingDataLabel.isHidden = true
        missingDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65).isActive = true
        missingDataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65).isActive = true
        missingDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        missingDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        standingsView.collectionView.dataSource = self
        standingsView.collectionView.delegate = self
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        viewModel.reloadData = {[weak self] isAvailable in
            guard let self = self else { return }
            if isAvailable {
                self.standingsView.collectionView.reloadData()
                self.standingsView.leageNameLabel.text = self.viewModel.leagueName
                self.missingDataLabel.isHidden = true
            } else {
                self.missingDataLabel.isHidden = false
                self.standingsView.collectionView.reloadData()
            }
            self.activityIndicator.stopAnimating()
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
            switch indexPath.row {
            case 1: cell.imageView.image = UIImage(systemName: "circle.fill")?.withTintColor(UIColor(red: 0.3569, green: 0.7333, blue: 0.5255, alpha: 1.0), renderingMode: .alwaysOriginal)
            case 2: cell.imageView.image = UIImage(systemName: "circle.fill")?.withTintColor(UIColor(red: 0.2627, green: 0.5961, blue: 0.9686, alpha: 1.0), renderingMode: .alwaysOriginal)
            case 3: cell.imageView.image = UIImage(systemName: "circle.fill")?.withTintColor(UIColor(red: 0.2627, green: 0.5961, blue: 0.9686, alpha: 1.0), renderingMode: .alwaysOriginal)
            case 4: cell.imageView.image = UIImage(systemName: "circle.fill")?.withTintColor(UIColor(red: 0.2627, green: 0.5961, blue: 0.9686, alpha: 1.0), renderingMode: .alwaysOriginal)
            case 5: cell.imageView.image = UIImage(systemName: "circle.fill")?.withTintColor(UIColor(red: 0.9686, green: 0.6863, blue: 0.2627, alpha: 1.0) , renderingMode: .alwaysOriginal)
            default: break
            }
        }
        return cell
    }
    
    
}
