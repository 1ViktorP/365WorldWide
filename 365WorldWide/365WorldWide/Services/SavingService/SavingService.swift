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
    
     func saveData<T: Encodable>(encodeData: T, key: String) {
        let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(encodeData) {
               print("saved")
               UserDefaults.standard.set(encoded, forKey: key)
           }
    }
    
     func retrieveData<T:Decodable>(key: String) -> T? {
        var data: T?
        if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
            print("tryToRetrieve")
                let decoder = JSONDecoder()
                if let loadedData = try? decoder.decode(T.self, from: savedData) {
                   print("retrieved")
                    data = loadedData
                }
        }
        return data
    }
}
