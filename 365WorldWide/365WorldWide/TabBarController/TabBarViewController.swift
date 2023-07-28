//
//  TabViewController.swift
//  TheActiveBoard
//
//  Created by MacBook on 09.02.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        lineView.backgroundColor = .white.withAlphaComponent(0.1)
        tabBar.addSubview(lineView)
        if #available(iOS 13, *) {
            let appearance = UITabBarAppearance()
            
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainYellowColor]
            appearance.backgroundColor = .mainBGColor
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(red: 0.1804, green: 0.2235, blue: 0.2824, alpha: 1.0)
            appearance.stackedLayoutAppearance.selected.iconColor = .mainYellowColor
            tabBar.standardAppearance = appearance
            // Update for iOS 15, Xcode 13
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
        }
    }
}
