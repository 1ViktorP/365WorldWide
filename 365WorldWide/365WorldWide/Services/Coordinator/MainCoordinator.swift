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
    
//    func popToPreviousVC() {
//        navigationController.popViewController(animated: true)
//    }
//
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
//    func openDetailVC() {
//        let detailVC = DetailViewController()
//        navigationController.pushViewController(detailVC, animated: true)
//    }
//
//    func openLoaderVC(viewModel: GameViewModel) {
//        let loaderVC = PreloaderViewController(loaderState: .loader, viewModel: viewModel)
//        navigationController.pushViewController(loaderVC, animated: true)
//    }
//
//    func openUnloaderVC(view: UIView) {
//        let loaderVC = PreloaderViewController(loaderState: .unloader, viewModel: nil)
//        loaderVC.modalPresentationStyle = .overCurrentContext
//        loaderVC.modalTransitionStyle = .crossDissolve
//        navigationController.pushViewController(loaderVC, animated: true)
//        view.window?.rootViewController = navigationController
//        view.window?.makeKeyAndVisible()
//    }
//    func openSettingsVC() {
//        let settingsVC = SettingsViewController()
//        navigationController.pushViewController(settingsVC, animated: true)
//    }
//
//    func openStatisticVC() {
//        let statVC = StatisticViewController()
//        navigationController.pushViewController(statVC, animated: true)
//    }
//
//    func openTermsVC(isTerms: Bool) {
//        let termsVC = TermsViewController(isTerms: isTerms)
//        navigationController.pushViewController(termsVC, animated: true)
//    }
//
//    func openGameVC(viewModel: GameViewModel) {
//        let gameVC = GameViewController(viewModel: viewModel)
//        navigationController.pushViewController(gameVC, animated: true)
//    }
//
//    func openStatusVC(controller: UIViewController, status: Status, dismissHandler: @escaping ((StatusDismiss)->Void)) {
//        let statusVC = StatusViewController(status: status, dismissHandler: dismissHandler)
//        statusVC.modalPresentationStyle = .overCurrentContext
//        statusVC.modalTransitionStyle = .crossDissolve
//        controller.present(statusVC, animated: true)
//    }
}


