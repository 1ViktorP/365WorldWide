//
//  MainCoordinator.swift
//  YourLucky
//
//  Created by MacBook on 27.06.2023.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let vc = LoaderViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popToPreviousVC() {
        navigationController.popViewController(animated: true)
    }

    func openOnboardingController() {
        let onboardingVC = OnboardingViewController()
        onboardingVC.modalPresentationStyle = .overCurrentContext
        onboardingVC.modalTransitionStyle = .crossDissolve
        navigationController.present(onboardingVC, animated: true)
    }
//
//    func openMainVC(from view: UIView) {
//        let mainVC = MainViewController()
//        mainVC.modalPresentationStyle = .overCurrentContext
//        mainVC.modalTransitionStyle = .crossDissolve
//        navigationController.pushViewController(mainVC, animated: true)
//        view.window?.rootViewController = navigationController
//        view.window?.makeKeyAndVisible()
//    }
//
    func openDetailVC(fixture: FixtureCellViewModel) {
        let detailVC = DetailEventViewController(fixture: fixture)
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func openH2HVC(codes: TeamCodeViewModel,fixture: FixtureCellViewModel) {
        let h2hVC = H2hViewController(fixture: fixture, codes: codes)
        navigationController.pushViewController(h2hVC, animated: true)
    }
    
    func openFixtureEventsVC(codes: TeamCodeViewModel,fixture: FixtureCellViewModel) {
        let h2hVC = FixtureEventsViewController(fixture: fixture, codes: codes)
        navigationController.pushViewController(h2hVC, animated: true)
    }
    
    func openFixtureStatVC(codes: TeamCodeViewModel,fixture: FixtureCellViewModel) {
        let fixtureStatVC = FixtureStatisticViewController(fixture: fixture, codes: codes)
        navigationController.pushViewController(fixtureStatVC, animated: true)
    }
    
    func openStandingsVC(codes: TeamCodeViewModel,fixture: FixtureCellViewModel) {
        let standingsVC = StandingsViewController(fixture: fixture, codes: codes)
        navigationController.pushViewController(standingsVC, animated: true)
    }
    
    func openLineUpVC(codes: TeamCodeViewModel,fixture: FixtureCellViewModel) {
        let lineUpVC = LineUpViewController(fixture: fixture, codes: codes)
        navigationController.pushViewController(lineUpVC, animated: true)
    }

    func openSavedEventsVC() {
        let statVC = SavedEventsViewController()
        navigationController.pushViewController(statVC, animated: true)
    }
//
    func openTermsVC(isTerms: Bool) {
        let termsVC = TermsViewController(isTerms: isTerms)
        navigationController.pushViewController(termsVC, animated: true)
    }
}


