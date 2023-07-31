//
//  SavedViewController.swift
//  365WorldWide
//
//  Created by MacBook on 28.07.2023.
//

import UIKit

class SavedViewController: UIViewController {
    
    private let saveView = SavedView()
    private var saveViewModel = SaveViewModel()
    private var coordinator: MainCoordinator?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
         label.textColor = .white
         label.text = "Saved Events"
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view = saveView
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        saveViewModel.retrieveFavorites()
    }
    
    private func setUp() {
        navigationController?.navigationBar.tintColor = .white.withAlphaComponent(0.5)
        navigationController?.navigationItem.backButtonTitle = "Saved Events"
        navigationItem.titleView = titleLabel
        
        view.addSubview(missingDataLabel)
        missingDataLabel.isHidden = true
        missingDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65).isActive = true
        missingDataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65).isActive = true
        missingDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        missingDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        saveView.fixturesCollectionView.dataSource = self
        saveView.fixturesCollectionView.delegate = self
        
        saveViewModel.reloadData = { isAvailable in
            if isAvailable {
                self.saveView.fixturesCollectionView.reloadData()
                self.missingDataLabel.isHidden = true
            } else {
                self.missingDataLabel.isHidden = false
                self.saveView.fixturesCollectionView.reloadData()
            }
        }
            
        guard let navigationController = navigationController else { return }
        coordinator = MainCoordinator(navigationController: navigationController)
    }
}

extension SavedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return saveViewModel.favoritesFixture.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FixtureCollectionViewCell.reuseIdentifier, for: indexPath) as! FixtureCollectionViewCell
            cell.configure(with: saveViewModel.favoritesFixture[indexPath.row])
        cell.favoriteButtonHandler = {
            self.saveViewModel.deleteFavoriteItem(fixture: self.saveViewModel.favoritesFixture[indexPath.row])
        }
        cell.conteinerView.saveButton.setImage(UIImage(systemName: "star.fill")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal), for: .normal)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIDevice.vibrate()
            coordinator?.openDetailVC(fixture: saveViewModel.favoritesFixture[indexPath.row])
    }
}


