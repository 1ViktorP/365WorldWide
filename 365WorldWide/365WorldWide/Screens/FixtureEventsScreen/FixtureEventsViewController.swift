//
//  FixtureEventsViewController.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class FixtureEventsViewController: UIViewController {

    private let fixtureView = FixtureEventsView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
         label.textColor = .white
         label.text = "Events"
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
    
    private var viewModel: FixtureEventsViewModel!
    private var teamCodes: TeamCodeViewModel!

    init(fixture: FixtureCellViewModel, codes: TeamCodeViewModel) {
        viewModel = FixtureEventsViewModel(fixture: fixture)
        teamCodes = codes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = fixtureView
        setUp()
    }
    
    private func setUp() {
        navigationController?.navigationBar.tintColor = .white.withAlphaComponent(0.5)
        navigationController?.navigationItem.backButtonTitle = "Detail"
        navigationItem.titleView = titleLabel
        
        fixtureView.collectionView.dataSource = self
        fixtureView.collectionView.delegate = self
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        viewModel.reloadData = { isAvailable in
            if isAvailable {
                self.activityIndicator.stopAnimating()
                self.fixtureView.collectionView.reloadData()
            } else {
                //add missing data label
            }
        }
        fixtureView.topBGView.configure(with: viewModel.fixture, codes: teamCodes)
    }
}
extension FixtureEventsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FixtureEventsCollectionViewCell.reuseIdentifier, for: indexPath) as! FixtureEventsCollectionViewCell
        cell.configure(with: viewModel.events[indexPath.row])
        return cell
    }
}
