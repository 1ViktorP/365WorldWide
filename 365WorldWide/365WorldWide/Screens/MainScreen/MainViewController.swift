//
//  MainViewController.swift
//  365WorldWide
//
//  Created by MacBook on 24.07.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private let mainView = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
    }
    
    private func setUp() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "All Events"
    }
   
}
