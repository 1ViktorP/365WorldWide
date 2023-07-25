//
//  MainViewController.swift
//  365WorldWide
//
//  Created by MacBook on 24.07.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private var mainView = MainView()
//    private let dateViewModel = DateViewModel()
//    private let mainViewModel = MainViewModel()
    private var coordinator: MainCoordinator!
    private var isFirstTime = true
   // let childVC = MenuViewController()
    private var activityIndicator: UIActivityIndicatorView = {
       let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        setUp()
        activityIndicator.startAnimating()
    }
    
    private func setUp() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "All Events"
       
        mainView.dateCollectionView.dataSource = self
        mainView.dateCollectionView.delegate = self
        mainView.fixturesCollectionView.dataSource = self
        mainView.fixturesCollectionView.delegate = self
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        guard let navigationController = navigationController else { return }
        coordinator = MainCoordinator(navigationController: navigationController)
    }
   
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        if isFirstTime {
           // animateScrollTo()
        }
    }

    
//    func animateScrollTo() {
//        UIView.animate(withDuration: 0.1, delay: 0) {
//            self.mainView.dateCollectionView.scrollToItem(at: IndexPath(row: self.dateViewModel.dateCell.count / 2 - 2, section: 0), at: .left, animated: false)
//        }
//            mainViewModel.fetchAllMatches(date: dateViewModel.dateCell[self.dateViewModel.dateCell.count / 2].dateForURL)
//    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.dateCollectionView {
            return 5// dateViewModel.dateCell.count
        } else {
            return 5//mainViewModel.isFiltered ? mainViewModel.filteredMathes.count : mainViewModel.matches.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.dateCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.reuseIdentifier, for: indexPath) as! DateCollectionViewCell
//            if indexPath.row == dateViewModel.dateCell.count / 2 {
//                cell.setUpiSSelected()
//            }
            //cell.textLabel.text = dateViewModel.dateCell[indexPath.row].date
                return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FixtureCollectionViewCell.reuseIdentifier, for: indexPath) as! FixtureCollectionViewCell
            //cell.configure(with: mainViewModel.isFiltered ? mainViewModel.filteredMathes[indexPath.row] : mainViewModel.matches[indexPath.row])
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIDevice.vibrate()
//        if collectionView == mainView.dateCollectionView {
//            activityIndicator.startAnimating()
//            mainViewModel.fetchAllMatches(date: dateViewModel.dateCell[indexPath.row].dateForURL)
//            mainView.fixturesCollectionView.reloadData()
//            if indexPath.row != dateViewModel.dateCell.count / 2 && isFirstTime {
//                let newIndexPath = IndexPath(row: dateViewModel.dateCell.count / 2 , section: 0)
//                guard let cell = collectionView.cellForItem(at: newIndexPath) as? HorizontalCollectionViewCell else { return }
//                cell.setUpIsUnselected()
//                isFirstTime = false
//            }
//        } else {
//            coordinator.openFixtureVC(fixtureData:  mainViewModel.isFiltered ? mainViewModel.filteredMathes[indexPath.row] : mainViewModel.matches[indexPath.row])
//        }
    }
}
