//
//  DetailEventViewController.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import UIKit

class DetailEventViewController: UIViewController {
    
    private let detailView = DetailEventView()
    private let viewModel = DetailEventViewModel()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
         label.textColor = .white
         label.text = "Detail Event"
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        setUp()
    }
    
    private func setUp() {
        navigationController?.navigationBar.tintColor = .white.withAlphaComponent(0.5)
        navigationController?.navigationItem.backButtonTitle = "Events"
        navigationItem.titleView = titleLabel
        detailView.collectionView.dataSource = self
        detailView.collectionView.delegate = self
    }
}

extension DetailEventViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.detailEventsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventTitleCollectionViewCell.reuseIdentifier, for: indexPath) as! EventTitleCollectionViewCell
        cell.titleLabel.text =  viewModel.detailEventsList[indexPath.row]
        return cell
    }
    
    
}
