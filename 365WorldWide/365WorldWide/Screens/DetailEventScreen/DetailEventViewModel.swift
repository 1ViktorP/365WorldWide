//
//  DetailEventViewModel.swift
//  365WorldWide
//
//  Created by MacBook on 25.07.2023.
//

import Foundation

struct TeamCodeViewModel {
    var homeTeamCode: String
    var awayTeamCode: String
}

class DetailEventViewModel {
    let detailEventsList = ["H2H", "Events", "Statistics", "Lineup", "League Standings"]
    
    var teamsCode = TeamCodeViewModel(homeTeamCode: "", awayTeamCode: "")
    
    func fetchTeamCodes(isHome: Bool, teamId: String) async {
        do {
            let isDownloaded = try await NetworkManager.shared.fetchData(endpoint: .getTeam(id: teamId))
            if isDownloaded {
                guard let data = LiveDataBuffer.upcomingData?.response else { return }
                if isHome {
                    teamsCode.homeTeamCode = data[0].team?.code ?? ""
                } else {
                    teamsCode.awayTeamCode = data[0].team?.code ?? ""
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    
    
}
