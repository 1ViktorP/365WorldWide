//
//  NavigationMenu.swift
//  TheBestSports
//
//  Created by MacBook on 28.02.2023.
//

import UIKit

protocol NavigationMenuDelegate: AnyObject {
    func share()
    func addReminder()
}

class NavigationMenu {
        
    weak var delegate: NavigationMenuDelegate?
    
    func addMenuToNavBar(isFixture: Bool = false) -> UIBarButtonItem {
        let shareAction = UIAction(title: "Share Match") { action in
            UIDevice.vibrate()
            self.delegate?.share()
        }
        
        
        let addReminderAction = UIAction(title: "Add reminder") { action in
            UIDevice.vibrate()
            self.delegate?.addReminder()
        }
            
        var children = [
                        shareAction,
                        addReminderAction,
                        ]
        
        let barButtonMenu = UIMenu(title: "", children: children)
  
        let item = UIBarButtonItem(image: UIImage(systemName: "ellipsis")?.withTintColor(.white, renderingMode: .alwaysOriginal), menu: barButtonMenu)
        return item
    }
}
