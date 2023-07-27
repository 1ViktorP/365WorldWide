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
        Task {
            await mainViewModel.fetchFixturesByDate(date: Date.getToday)
        }
        mainViewModel.reloadData = { isAvailable in
            if isAvailable {
                self.mainView.fixturesCollectionView.reloadData()
            } else {
                //add missing data label
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
   
    override func viewDidAppear(_ animated: Bool) {
        if isFirstTime {
           // animateScrollTo()
        }
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
    
//    func animateScrollTo() {
//        UIView.animate(withDuration: 0.1, delay: 0) {
//            self.mainView.dateCollectionView.scrollToItem(at: IndexPath(row: self.dateViewModel.dateCell.count / 2 - 2, section: 0), at: .left, animated: false)
//        }
//            mainViewModel.fetchAllMatches(date: dateViewModel.dateCell[self.dateViewModel.dateCell.count / 2].dateForURL)
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
