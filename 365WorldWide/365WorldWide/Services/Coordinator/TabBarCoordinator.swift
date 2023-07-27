//
//  TabBarCoordinator.swift
//  BlazeSport
//
//  Created by MacBook on 16.05.2023.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
        
    var view: UIView!
    
    init(view: UIView) {
        self.view = view
        navigationController = UINavigationController()
    }
    
    func start() {
        let tabBarViewController = TabBarViewController()
        tabBarViewController.selectedIndex = 2
        tabBarViewController.viewControllers = setUp()
        view.window?.rootViewController = tabBarViewController
        view.window?.makeKeyAndVisible()
    }
    
    func setUp() -> [UIViewController] {
        let mainVC = AllEventsViewController()
        //let edges = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let mapVC = MapViewController()
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "geoIconTabBar"), tag: 1)
        let mainVCIcon = UIImage(named: "eventsIconTabBar")
        mainVC.tabBarItem = UITabBarItem(title: "Events", image: mainVCIcon, tag: 2)
        let settingVC = SettingsViewController()
        settingVC.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: "menuIconTabBar"), tag: 3)
        
        return [
            UINavigationController(rootViewController: mapVC),
            UINavigationController(rootViewController: mainVC),
            UINavigationController(rootViewController: settingVC),
        ]
        
    }
}
