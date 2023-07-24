//
//  LoaderViewController.swift
//  365WorldWide
//
//  Created by MacBook on 24.07.2023.
//

import UIKit

class LoaderViewController: UIViewController {
    
    private let loaderView = LoaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = loaderView
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loaderView.progressView.setProgress(0.1, animated: true)
        UIView.animate(withDuration: 2) {
            self.loaderView.progressView.setProgress(1, animated: true)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loaderView.startButton.isHidden = false
        }
    }
    
    private func setUp() {
        loaderView.startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
    }
    
    @objc func didTapStartButton() {
        guard let navigationController = navigationController else { return }
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.openOnboardingController()
    }
}
