//
//  Coordinator.swift
//  YourLucky
//
//  Created by MacBook on 27.06.2023.
//


import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
    
}
