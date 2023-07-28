//
//  MainViewController.swift
//  365WorldWide
//
//  Created by MacBook on 24.07.2023.
//

import UIKit

class AllEventsViewController: UIViewController {
    
    private var mainView = MainView()
    private let dateViewModel = DateViewModel()
    private let mainViewModel = MainViewModel()
    private var coordinator: MainCoordinator?
    private var isFirstTime = true
    private var date = Date()
    private var isSaved = false
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        setUp()
        activityIndicator.startAnimating()
    }
    
  
    private func setUp() {
        view.addSubview(missingDataLabel)
        missingDataLabel.isHidden = true
        missingDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65).isActive = true
        missingDataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65).isActive = true
        missingDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        missingDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        Task {
            await mainViewModel.fetchFixturesByDate(date: Date.getToday)
        }
        mainViewModel.reloadData = { isAvailable in
            if isAvailable {
                self.mainView.fixturesCollectionView.reloadData()
                self.missingDataLabel.isHidden = true
            } else {
                self.missingDataLabel.isHidden = false
                self.mainView.fixturesCollectionView.reloadData()
                
            }
            self.activityIndicator.stopAnimating()
        }
       
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "All Events"
        dateViewModel.prepareDateCell(date: Date())
        mainView.dateCollectionView.dataSource = self
        mainView.dateCollectionView.delegate = self
        mainView.fixturesCollectionView.dataSource = self
        mainView.fixturesCollectionView.delegate = self
        mainView.calendarButton.addTarget(self, action: #selector(didTapCalendarButton), for: .touchUpInside)
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        guard let navigationController = navigationController else { return }
        coordinator = MainCoordinator(navigationController: navigationController)
    }

    @objc func didTapCalendarButton() {
        coordinator?.openCalendarVC(date: date, dismissHandler: { [weak self] date in
            guard let self = self else { return }
            self.date = date
            self.dateViewModel.prepareDateCell(date: date)
            self.mainView.dateCollectionView.reloadData()
            self.isFirstTime = true
            Task {
                await self.mainViewModel.fetchFixturesByDate(date: Date.formatForURL(date: date))
            }
        })
    }
    
    @objc func didTapSaveButton(sender: UIButton) {
        if !isSaved {
            isSaved = false
            sender.setImage(UIImage(systemName: "star.fill")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal), for: .normal)
         //   addToFavorites(fixture: fixture)
        } else {
            isSaved = true
            sender.setImage(UIImage(systemName: "star")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal), for: .normal)
           // deleteFavoriteItem(fixture: fixture)
        }
    }
//    
    func retrieveAndCheckFavorites(fixtureID: String) -> Bool {
        let favoriteFixture = SaveManager.shared.getDataFromFavorite() as [FixtureCellViewModel]
        if favoriteFixture.contains(where: { $0.id == fixtureID }) {
            return true
        } else {
          return false
        }
    }
//
//    func addToFavorites(fixture: FixtureCellViewModel) {
//        saveBarButtonItem.image = UIImage(systemName: "star.fill")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal)
//        SaveManager.shared.setDataToFavorites(data: fixture)
//    }
////
//    func deleteFavoriteItem(fixture: FixtureCellViewModel) {
//        saveBarButtonItem.image = UIImage(systemName: "star")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal)
//        SaveManager.shared.removeDataFromFavorites(id: fixture.id)
//    }
}

extension AllEventsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.dateCollectionView {
            return dateViewModel.dateCell.count
        } else {
            return mainViewModel.fixtures.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.dateCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.reuseIdentifier, for: indexPath) as! DateCollectionViewCell
            if indexPath.row == dateViewModel.dateCell.count / 2 {
                cell.setUpiSSelected()
            }
            cell.dateLabel.text = dateViewModel.dateCell[indexPath.row].date
            cell.dayLabel.text =  dateViewModel.dateCell[indexPath.row].day
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FixtureCollectionViewCell.reuseIdentifier, for: indexPath) as! FixtureCollectionViewCell
            mainViewModel.fixtures[indexPath.row].isFavorite = retrieveAndCheckFavorites(fixtureID: mainViewModel.fixtures[indexPath.row].id)
            cell.favoriteButtonHandler = { favoriteButton in
                favoriteButton.addTarget(self, action: #selector(self.didTapSaveButton), for: .touchUpInside)
                print("saved: \(self.isSaved)" )
            }
            cell.configure(with: mainViewModel.fixtures[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIDevice.vibrate()
        if collectionView == mainView.dateCollectionView {
            activityIndicator.startAnimating()
            Task {
                let _date = dateViewModel.dateCell[indexPath.row].dateForURL
               await mainViewModel.fetchFixturesByDate(date: _date)
            }
            if indexPath.row != dateViewModel.dateCell.count / 2 && isFirstTime {
                let newIndexPath = IndexPath(row: dateViewModel.dateCell.count / 2 , section: 0)
                guard let cell = collectionView.cellForItem(at: newIndexPath) as? DateCollectionViewCell else { return }
                cell.setUpIsUnselected()
                isFirstTime = false
            }
        } else {
            coordinator?.openDetailVC(fixture: mainViewModel.fixtures[indexPath.row])
        }
    }
}
