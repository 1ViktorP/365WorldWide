//
//  SaveViewModel.swift
//  365WorldWide
//
//  Created by MacBook on 28.07.2023.
//

import Foundation

class SaveViewModel {
    var favoritesFixture: [FixtureCellViewModel] = []
   
    var reloadData: ((Bool) -> Void) = { _ in }
    
    func retrieveFavorites() {
        favoritesFixture.removeAll()
        favoritesFixture = SaveManager.shared.getDataFromFavorite() as [FixtureCellViewModel]
        print("retrieve: \(favoritesFixture.count)")
        if favoritesFixture.isEmpty {
            reloadData(false)
        } else {
            reloadData(true)
        }
    }

    func deleteFavoriteItem(fixture: FixtureCellViewModel) {
        favoritesFixture.removeAll(where: {$0.id == fixture.id})
        SaveManager.shared.removeDataFromFavorites(id: fixture.id)
         reloadData(true)
    }
}
