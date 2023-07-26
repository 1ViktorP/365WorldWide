//
//  EventStatisticViewController.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class EventStatisticViewController: UIViewController {

    private let statView = EventStatisticView()
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
    
    private var viewModel: H2hViewModel!
    private var teamCodes: TeamCodeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view = statView
        setUp()
    }
    
    private func setUp() {
        navigationController?.navigationBar.tintColor = .white.withAlphaComponent(0.5)
        navigationController?.navigationItem.backButtonTitle = "Detail"
        navigationItem.titleView = titleLabel
        
        statView.collectionView.dataSource = self
        statView.collectionView.delegate = self
    }
}
extension EventStatisticViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BallPossesionCollectionViewCell.reuseIdentifier, for: indexPath) as! BallPossesionCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventStatisticCollectionViewCell.reuseIdentifier, for: indexPath) as! EventStatisticCollectionViewCell
            return cell
        }
    }
    
    
}
