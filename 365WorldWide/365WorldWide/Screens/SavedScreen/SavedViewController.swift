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
        
        saveView.fixturesCollectionView.dataSource = self
        saveView.fixturesCollectionView.delegate = self
        
        saveViewModel.reloadData = { _ in
            self.saveView.fixturesCollectionView.reloadData()
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


