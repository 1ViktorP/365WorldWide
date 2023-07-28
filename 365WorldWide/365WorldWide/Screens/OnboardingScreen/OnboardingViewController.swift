//
//  OnboardingViewController.swift
//  BetCounter
//
//  Created by MacBook on 27.04.2023.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    private let onboardingView = OnboardingView()
    private let onboardingViewModel = OnboardingViewModel()
   // private var tabBarCoordinator: TabBarCoordinator?
    private var row = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view = onboardingView
        setUp()
    }
    
    private func setUp() {
        onboardingView.collectionView.dataSource = self
        onboardingView.collectionView.delegate = self
        onboardingViewModel.fillModel()
        onboardingView.startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        onboardingView.skipButton.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
        
        onboardingView.rowHandler = { [weak self] row in
            guard let self = self else { return }
            self.row = row
            self.onboardingView.titleLabel.text = self.onboardingViewModel.onboardingData[row].title
            self.onboardingView.subTitleLabel.text = self.onboardingViewModel.onboardingData[row].subTitle

        }
    }
    
    @objc func didTapStartButton() {
        UIDevice.vibrate()
            if row != 2 {
                self.onboardingView.collectionView.scrollToItem(at: IndexPath(row: row + 1, section: 0), at: .left, animated: true)
            } else {
                let tabBarCoordinator = TabBarCoordinator(view: self.view)
                tabBarCoordinator.start()
            }
    }
    
    @objc func didTapSkipButton() {
        let tabBarCoordinator = TabBarCoordinator(view: self.view)
        tabBarCoordinator.start()
    }
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingViewModel.onboardingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.bgImageView.image = UIImage(named: onboardingViewModel.onboardingData[indexPath.row].bgImageName)
        if indexPath.row == 1 {
            cell.smallBGImageView.isHidden = true
            cell.smallBG2ImageView.isHidden = false
        } else if indexPath.row == 2 {
            cell.smallBGImageView.isHidden = true
            cell.smallBG2ImageView.isHidden = true
        }
        return cell
    }
}
