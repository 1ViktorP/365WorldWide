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
    private var navigationMenu = NavigationMenu()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
         label.textColor = .white
         label.text = "Detail Event"
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    private let fixtureViewModel: FixtureCellViewModel!
    private var coordinator: MainCoordinator?
    private var saveBarButtonItem: UIBarButtonItem!
    private var isSaved = false
    
    init(fixture: FixtureCellViewModel) {
        self.fixtureViewModel = fixture
        super.init(nibName: nil, bundle: nil)
        configure(with: fixture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        setUp()
    }
    
    private func setUp() {
        navigationController?.navigationBar.tintColor = .white.withAlphaComponent(0.5)
        navigationController?.navigationItem.backButtonTitle = "Events"
        navigationItem.titleView = titleLabel
        navigationMenu.delegate = self
        saveBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didTapSaveButtonItem))
        navigationItem.rightBarButtonItems = [navigationMenu.addMenuToNavBar(isFixture: true), saveBarButtonItem,]
        retrieveAndCheckFavorites()
        detailView.collectionView.dataSource = self
        detailView.collectionView.delegate = self
        
        Task {
            await viewModel.fetchTeamCodes(isHome: true, teamId: fixtureViewModel.homeTeamId)
            await viewModel.fetchTeamCodes(isHome: false, teamId: fixtureViewModel.awayTeamId)
        }
        
        guard let navigationController = navigationController else { return }
        coordinator = MainCoordinator(navigationController: navigationController)
    }
    
   @objc func didTapSaveButtonItem() {
       if !isSaved {
           isSaved = true
           addToFavorites()
       } else {
           isSaved = false
           deleteFavoriteItem()
       }
    }
    
        func retrieveAndCheckFavorites() {
            let favoriteFixture = SaveManager.shared.getDataFromFavorite() as [FixtureCellViewModel]
            if favoriteFixture.contains(where: { $0.id == fixtureViewModel.id }) {
                saveBarButtonItem.image = UIImage(systemName: "star.fill")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal)
                isSaved = true
            } else {
                saveBarButtonItem.image = UIImage(systemName: "star")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal)
                isSaved = false
            }
        }
    
        func addToFavorites() {
            saveBarButtonItem.image = UIImage(systemName: "star.fill")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal)
            SaveManager.shared.setDataToFavorites(data: fixtureViewModel)
        }
    
        func deleteFavoriteItem() {
            saveBarButtonItem.image = UIImage(systemName: "star")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal)
            SaveManager.shared.removeDataFromFavorites(id: fixtureViewModel.id)
        }
    
    func configure(with viewModel: FixtureCellViewModel) {
        detailView.fixtureView.homeTeamView.teamNameLabel.text = viewModel.homeTeamName
        detailView.fixtureView.homeTeamView.teamImageView.kf.setImage(with: viewModel.homeTeamIcon)
        detailView.fixtureView.awayTeamView.teamNameLabel.text = viewModel.awayTeamName
        detailView.fixtureView.awayTeamView.teamImageView.kf.setImage(with: viewModel.awayTeamIcon)
        detailView.fixtureView.statusLabel.text = viewModel.status
        detailView.fixtureView.placeLabel.text = viewModel.city + "," + viewModel.country
        detailView.leagueLabelStack.rightLabel.text = viewModel.leagueName
        detailView.dateLabelStack.rightLabel.attributedText = attrText(Date.formatDateForDetailView(date: viewModel.date))

        if viewModel.status == "1H" || viewModel.status == "HT" || viewModel.status == "2H" ||  viewModel.status == "ET" ||
            viewModel.status == "BT" ||  viewModel.status == "P" {
            detailView.fixtureView.dateLabel.isHidden = true
            detailView.fixtureView.minuteLabel.isHidden = false
            detailView.fixtureView.minuteLabel.text = viewModel.minute + "'"
            detailView.fixtureView.timeScoreLabel.text = viewModel.homeTeamScore + " - " + viewModel.awayTeamScore
        } else if viewModel.status == "FT" {
            detailView.fixtureView.timeScoreLabel.text = viewModel.homeTeamScore + " - " + viewModel.awayTeamScore
            detailView.fixtureView.minuteLabel.isHidden = true
            detailView.fixtureView.dateLabel.isHidden = false
            detailView.fixtureView.dateLabel.text = Date.formatDateForCell(date: viewModel.date)
        } else {
            detailView.fixtureView.timeScoreLabel.text =  Date.formatHours(date: viewModel.date)
            detailView.fixtureView.minuteLabel.isHidden = true
        }
    }
    
    private func attrText(_ text: String) -> NSMutableAttributedString {
        let attrText = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: text.count - 5) 
        attrText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white.withAlphaComponent(0.5), range: range)
        return attrText
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: coordinator?.openH2HVC(codes: viewModel.teamsCode, fixture: fixtureViewModel)
        case 1: coordinator?.openFixtureEventsVC(codes: viewModel.teamsCode, fixture: fixtureViewModel)
        case 2: coordinator?.openFixtureStatVC(codes: viewModel.teamsCode, fixture: fixtureViewModel)
        case 3: coordinator?.openLineUpVC(codes: viewModel.teamsCode, fixture: fixtureViewModel)
        case 4: coordinator?.openStandingsVC(codes: viewModel.teamsCode, fixture: fixtureViewModel)
        default: break
        }
    }
}

extension DetailEventViewController: NavigationMenuDelegate {
    func addReminder() {
        let date = fixtureViewModel.date
        if (date > Date()) {
            let date = date
            let home = fixtureViewModel.homeTeamName
            let away = fixtureViewModel.awayTeamName
            let subTitle = home + " - " + away
            NotificationManager.setNotifications(title: "Fixture is Starting", subTitle: subTitle, date: date)
        }
    }
    
    func share() {
        let message = "Let's share to your friends"
        if let link = NSURL(string: "http://yoururl.com")
        {
            let objectsToShare = [message, link]  as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true)
        }
    }
}
