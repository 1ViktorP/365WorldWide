//
//  LineUpViewController.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class LineUpViewController: UIViewController {

    private let lineUpView = LineUpView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
         label.textColor = .white
         label.text = "Lineup"
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
    
    private var viewModel: LineUpViewModel!
    private var teamCodes: TeamCodeViewModel!
    
    init(fixture: FixtureCellViewModel, codes: TeamCodeViewModel) {
        viewModel = LineUpViewModel(fixture: fixture)
        teamCodes = codes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = lineUpView
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
        
        lineUpView.collectionView.dataSource = self
        lineUpView.collectionView.delegate = self
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        viewModel.reloadData = { isAvailable in
            if isAvailable {
                self.lineUpView.collectionView.reloadData()
                self.missingDataLabel.isHidden = true
            } else {
                self.missingDataLabel.isHidden = false
                self.lineUpView.collectionView.reloadData()
                
            }
            self.activityIndicator.stopAnimating()
        }
        lineUpView.topBGView.configure(with: viewModel.fixture, codes: teamCodes)
    }
}
extension LineUpViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.lineUp.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormationCollectionViewCell.reuseIdentifier, for: indexPath) as! FormationCollectionViewCell
            cell.formationLabelStack.leftLabel.text = viewModel.homeTeamFormation
            cell.formationLabelStack.rightLabel.text = viewModel.awayTeamFormation
            cell.homeFormationImageView.image = UIImage(named: viewModel.homeTeamFormationIcon)
            cell.awayFormationImageView.image = UIImage(named: viewModel.awayTeamFormationIcon)
            cell.homeTeamIconImageView.kf.setImage(with: viewModel.fixture.homeTeamIcon)
            cell.awayTeamIconImageView.kf.setImage(with: viewModel.fixture.awayTeamIcon)
            cell.codesLabelStack.leftLabel.text = teamCodes.homeTeamCode
            cell.codesLabelStack.rightLabel.text = teamCodes.awayTeamCode
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LineUpCollectionViewCell.reuseIdentifier, for: indexPath) as! LineUpCollectionViewCell
            cell.configure(with: viewModel.lineUp[indexPath.row])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LineUpHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! LineUpHeaderCollectionReusableView
            header.homeTeamIconImageView.kf.setImage(with: viewModel.fixture.homeTeamIcon)
            header.awayTeamIconImageView.kf.setImage(with: viewModel.fixture.awayTeamIcon)
            return header
        }
        return UICollectionReusableView()
    }
}
