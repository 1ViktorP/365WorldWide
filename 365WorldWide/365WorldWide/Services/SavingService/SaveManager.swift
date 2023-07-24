//
//  SaveManager.swift
//  YourLucky
//
//  Created by MacBook on 10.07.2023.
//

import Foundation

class SaveGameManager {
    
    static var shared = SaveGameManager()
    
    func isFirstTime(forKey: String) -> Bool {
        return SavingService.shared.isFirstTime(forKey: forKey)
    }
}
