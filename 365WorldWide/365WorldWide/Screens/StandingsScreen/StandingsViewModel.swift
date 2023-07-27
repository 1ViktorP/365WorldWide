//
//  StandingsViewModel.swift
//  365WorldWide
//
//  Created by MacBook on 27.07.2023.
//

import Foundation

struct StandingsCellViewModel {
    let rank: String
    let teamName: String
    let teamIcon: URL?
    let played: String
    let wins: String
    let draws: String
    let loses: String
    let goalsDiff: String
    let points: String
    let description: String
}

class StandingsViewModel {
    
    var standingsList: [StandingsCellViewModel] = []
    var reloadData: ( @MainActor (Bool)->Void) = { _ in }
    var fixture: FixtureCellViewModel!
    var leagueName: String = ""
    
    init(fixture: FixtureCellViewModel) {
        self.fixture = fixture
        Task {
            await fetchStandings(leagueID: fixture.leagueId, season: String(fixture.season))
        }
    }
    
    func fetchStandings(leagueID: String, season: String) async {
        do {
            let isDownloaded = try await NetworkManager.shared.fetchData(endpoint: .getStandings(leagueId: leagueID, season: season))
            if isDownloaded {
                guard let data = LiveDataBuffer.upcomingData else { return }
                leagueName = data.response.first?.league?.name ?? ""
                guard let standings = data.response.first?.league?.standings?.first else { return }
               let _standings = standings.sorted(by: {$0.rank ?? 0 < $1.rank ?? 0})
                self.standingsList = _standings.map({ standing in
                    StandingsCellViewModel(rank: String(standing.rank ?? 0),
                                           teamName: standing.team?.name ?? "",
                                           teamIcon: URL(string: standing.team?.logo ?? ""),
                                           played: String(standing.all?.played ?? 0),
                                           wins: String(standing.all?.win ?? 0),
                                           draws: String(standing.all?.draw ?? 0),
                                           loses: String(standing.all?.lose ?? 0),
                                           goalsDiff: String(standing.goalsDiff ?? 0),
                                           points: String(standing.points ?? 0),
                                           description: standing.description ?? "")
                })
        await reloadData(true)
    } else {
        await reloadData(false)
    }
} catch let error {
    print(error)
    await reloadData(false)
}
    }
}
