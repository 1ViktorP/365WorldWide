//
//  TermsViewController.swift
//  YourLucky
//
//  Created by MacBook on 07.07.2023.
//

import UIKit

class TermsViewController: UIViewController {
    
    private let textView = UITextView()
    private var isTerms: Bool!
    
   private let titleLabel: UILabel = {
       let label = UILabel()
       label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.text = ""
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    init(isTerms: Bool = false) {
        self.isTerms = isTerms
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
    private func setUp() {
        navigationController?.navigationBar.tintColor = .white.withAlphaComponent(0.5)
        navigationController?.navigationItem.backButtonTitle = "Menu"
        self.view.backgroundColor = .mainBGColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textView)
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .white
        
      
        if isTerms {
            textView.text = TermsPolicy.terms
            titleLabel.text = "Terms"
            navigationItem.titleView = titleLabel
        } else {
            textView.text = TermsPolicy.policy
            titleLabel.text = "Policy"
            navigationItem.titleView = titleLabel
        }
        
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func didTapLeftButton() {
        UIDevice.vibrate()
        guard let navigationController = navigationController else { return }
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.popToPreviousVC()
    }
}
