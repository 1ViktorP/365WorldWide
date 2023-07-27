//
//  LineUpViewModel.swift
//  365WorldWide
//
//  Created by MacBook on 27.07.2023.
//

import Foundation

struct LineUpCellViewModel {
    var playerNameHomeTeam: String = ""
    var playerPositioHomeTeam: String = ""
    var playerNameAwayTeam: String = ""
    var playerPositioAwayTeam: String = ""
}

class LineUpViewModel {
    var lineUp: [LineUpCellViewModel] = []
    var homeTeamFormation: String = ""
    var awayTeamFormation: String = ""
    var homeTeamFormationIcon: String = ""
    var awayTeamFormationIcon: String = ""
    
    var reloadData: ( @MainActor (Bool)->Void) = { _ in }
    var fixture: FixtureCellViewModel
    init(fixture: FixtureCellViewModel) {
        self.fixture = fixture
        Task {
            await fetchFixtureLineUp(id: fixture.id)
        }
    }
    
    func fetchFixtureLineUp(id: String) async {
        do {
            let isDownloaded = try await NetworkManager.shared.fetchData(endpoint: .getLineUp(fixtureId: id))
            if isDownloaded {

                guard let data = LiveDataBuffer.upcomingData else { return }
                if !data.response.isEmpty {
                    data.response[0].startXI?.enumerated().forEach({ (index,item) in
                        var awayPlayerName = data.response[1].startXI?[index].player?.name ?? ""
                        var awayPlayerPos = data.response[1].startXI?[index].player?.pos ?? ""
                            self.lineUp.append(LineUpCellViewModel(playerNameHomeTeam: item.player?.name ?? "",
                                                                   playerPositioHomeTeam: item.player?.pos ?? "",
                                                                   playerNameAwayTeam: awayPlayerName, playerPositioAwayTeam: awayPlayerPos
                                                                    ))
                        })
                        self.homeTeamFormation = data.response[0].formation ?? ""
                        self.awayTeamFormation = data.response[1].formation ?? ""
                    self.homeTeamFormationIcon = getFormation(isHome: true, formation: self.homeTeamFormation)
                    self.awayTeamFormationIcon = getFormation(isHome: false, formation: self.awayTeamFormation)
                    await reloadData(true)
                    }
                } else {
                    await reloadData(false)
                }
            } catch let error {
                print(error)
                await reloadData(false)
            }
        }
    
    private func getFormation(isHome: Bool,formation: String) -> String {

        var _formation = formation
        _formation.removeAll(where: {$0 == "-"})
        if isHome {
            return  "homeFormation=" + _formation
        } else {
            return "awayFormation=" + _formation
        }
    }
    
    }
    

