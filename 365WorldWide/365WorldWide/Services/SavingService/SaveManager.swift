//
//  SaveManager.swift
//  YourLucky
//
//  Created by MacBook on 10.07.2023.
//

import Foundation

class SaveManager {
    
    static var shared = SaveManager()
    
    func isFirstTime(forKey: String) -> Bool {
        return SavingService.shared.isFirstTime(forKey: forKey)
    }
    
    func setDataToFavorites(data: FixtureCellViewModel) {
        var array = getDataFromFavorite() as [FixtureCellViewModel]
        array.append(data)
        
        SavingService.shared.saveData(encodeData: array, key: "favorites")
    }
    
    func removeDataFromFavorites(id: String) {
            var array = getDataFromFavorite() as [FixtureCellViewModel]
             guard let index = array.firstIndex(where: {$0.id == id}) else { return }
            array.remove(at: index)
        SavingService.shared.saveData(encodeData: array, key: "favorites")
    }
    
    func getDataFromFavorite() -> [FixtureCellViewModel] {
        if let fixtures: [FixtureCellViewModel] = SavingService.shared.retrieveData(key: "favorites") {
            return fixtures
        } else {
            return []
        }
    }
}
