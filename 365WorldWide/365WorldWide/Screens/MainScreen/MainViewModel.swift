//
//  MainViewModel.swift
//  365WorldWide
//
//  Created by MacBook on 26.07.2023.
//

import Foundation

class MainViewModel {
    var fixtures: [FixtureCellViewModel] = []
    var reloadData: ( @MainActor (Bool)->Void) = { _ in }
    
    func fetchFixturesByDate(date: String) async {
        fixtures.removeAll()
        let favoriteFixtures = SaveManager.shared.getDataFromFavorite() as [FixtureCellViewModel]
        do {
            let isDownloaded = try await NetworkManager.shared.fetchData(endpoint: .getFixturesByDate(date: date))
            if isDownloaded {
                guard let data = LiveDataBuffer.upcomingData?.response else { return }
                data.forEach { item in
                    fixtures.append(FixtureCellViewModel(homeTeamIcon: URL(string: item.teams?.home?.logo ?? ""),
                                                         homeTeamName: item.teams?.home?.name ?? "",
                                                         homeTeamScore:  String(item.goals?.home ?? -1),
                                                         awayTeamIcon: URL(string: item.teams?.away?.logo ?? ""),
                                                         awayTeamName: item.teams?.away?.name ?? "",
                                                         awayTeamScore: String(item.goals?.away ?? -1),
                                                         status: item.fixture?.status?.short ?? "",
                                                         dateStr: Date.formatHours(date: item.fixture?.date ?? Date()),
                                                         isFavorite: checkFavorites(fixtureID: String(item.fixture?.id ?? 0), favoriteFixture: favoriteFixtures),
                                                         id: String(item.fixture?.id ?? 0),
                                                         date: item.fixture?.date ?? Date(),
                                                         leagueId: String(item.league?.id ?? 0),
                                                         leagueName: item.league?.name ?? "",
                                                         homeTeamId: String(item.teams?.home?.id ?? 0),
                                                         awayTeamId: String(item.teams?.away?.id ?? 0),
                                                         minute: String(item.fixture?.status?.elapsed ?? 00),
                                                         city: item.fixture?.venue?.city ?? "",
                                                         country: item.league?.country ?? "",
                                                         season: item.league?.season ?? 0)
                                                        )
                }
                await reloadData(true)
            } else {
                await reloadData(false)
            }
        } catch let error {
            print(error)
            await reloadData(false)
        }
        
    }
    
    private func addScore(goals: Goals?) -> String {
        guard let goals = goals else { return ""}
        return String(goals.home ?? 0) + "-" + String(goals.away ?? 0)
    }
    
    func checkFavorites(fixtureID: String, favoriteFixture: [FixtureCellViewModel]) -> Bool {
        if favoriteFixture.contains(where: { $0.id == fixtureID }) {
            return true
        } else {
          return false
        }
    }

    func addToFavorites(fixture: FixtureCellViewModel) {
        SaveManager.shared.setDataToFavorites(data: fixture)
    }

    func deleteFavoriteItem(fixture: FixtureCellViewModel) {
        SaveManager.shared.removeDataFromFavorites(id: fixture.id)
    }
}
