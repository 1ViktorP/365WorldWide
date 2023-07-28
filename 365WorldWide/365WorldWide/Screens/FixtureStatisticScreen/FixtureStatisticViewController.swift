//
//  EventStatisticViewController.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class FixtureStatisticViewController: UIViewController {

    private let statView = FixtureStatisticView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
         label.textColor = .white
         label.text = "Statistic"
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
    
    private var viewModel: FixtureStatViewModel!
    private var teamCodes: TeamCodeViewModel!
    
    init(fixture: FixtureCellViewModel, codes: TeamCodeViewModel) {
        viewModel = FixtureStatViewModel(fixture: fixture)
        teamCodes = codes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = statView
        setUp()
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
        
        statView.collectionView.dataSource = self
        statView.collectionView.delegate = self
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        viewModel.reloadData = { isAvailable in
            if isAvailable {
                self.statView.collectionView.reloadData()
                self.missingDataLabel.isHidden = true
            } else {
                self.missingDataLabel.isHidden = false
                self.statView.collectionView.reloadData()
                
            }
            self.activityIndicator.stopAnimating()
        }
        statView.topBGView.configure(with: viewModel.fixture, codes: teamCodes)
    }
}
extension FixtureStatisticViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.fixtureStat.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BallPossesionCollectionViewCell.reuseIdentifier, for: indexPath) as! BallPossesionCollectionViewCell
            if let ballPossesion = viewModel.ballPossesion {
                cell.configure(with: ballPossesion)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventStatisticCollectionViewCell.reuseIdentifier, for: indexPath) as! EventStatisticCollectionViewCell
            cell.configure(with: viewModel.fixtureStat[indexPath.row])
            return cell
        }
    }
    
    
}
