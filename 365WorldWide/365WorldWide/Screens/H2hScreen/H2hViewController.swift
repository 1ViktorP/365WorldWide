//
//  H2hViewController.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class H2hViewController: UIViewController {

    private let h2hView = H2hView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
         label.textColor = .white
         label.text = "H2H"
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
    
    private var viewModel: H2hViewModel!
    private var teamCodes: TeamCodeViewModel!
    
    init(fixture: FixtureCellViewModel, codes: TeamCodeViewModel) {
        viewModel = H2hViewModel(fixture: fixture)
        teamCodes = codes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = h2hView
        
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
        
        h2hView.collectionView.dataSource = self
        h2hView.collectionView.delegate = self
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        viewModel.reloadData = { isAvailable in
            if isAvailable {
                self.h2hView.collectionView.reloadData()
                self.missingDataLabel.isHidden = true
            } else {
                self.missingDataLabel.isHidden = false
                self.h2hView.collectionView.reloadData()
                
            }
            self.activityIndicator.stopAnimating()
        }
        h2hView.topBGView.configure(with: viewModel.fixture, codes: teamCodes)
    }
}

extension H2hViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.h2HCellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: H2hCollectionViewCell.reuseIdentifier, for: indexPath) as! H2hCollectionViewCell
        cell.configure(with: viewModel.h2HCellViewModel[indexPath.row])
        return cell
    }
}
