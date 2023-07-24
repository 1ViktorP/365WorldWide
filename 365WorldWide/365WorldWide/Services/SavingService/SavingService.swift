//
//  SavingService.swift
//  YourLucky
//
//  Created by MacBook on 10.07.2023.
//

import Foundation

class SavingService {
    
    static var shared = SavingService()
    
    func isFirstTime(forKey: String) -> Bool {
        if UserDefaults.standard.value(forKey: forKey) == nil {
            UserDefaults.standard.set(false, forKey: forKey)
            return true
        } else {
            return false
        }
    }
    
    func saveData<GameType: Codable>(encodeData: GameType, key: String) {
        let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(encodeData) {
               UserDefaults.standard.set(encoded, forKey: key)
           }
    }
    
    func retrieveData<GameType: Codable>(key: String) -> GameType? {
        var data: GameType?
        if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let loadedData = try? decoder.decode(GameType.self, from: savedData) {
                   print("retrieved")
                    data = loadedData
                   return data
                }
        } else {
            print("cant retrieve")
        }
        return data
    }
}
