//
//  FixtureStatViewModel.swift
//  365WorldWide
//
//  Created by MacBook on 27.07.2023.
//

import Foundation

struct FixtureStatCellViewModel {
    let type: String
    let homeTeamValue: String
    let awayTeamValue: String
    let progressHomeTeam: Float
    let progressAwayTeam: Float
}

class FixtureStatViewModel {
   
    var reloadData: ( @MainActor (Bool)->Void) = { _ in }
    var fixture: FixtureCellViewModel
    var fixtureStat: [FixtureStatCellViewModel] = []
    var ballPossesion: FixtureStatCellViewModel?
   
    init(fixture: FixtureCellViewModel) {
        self.fixture = fixture
        Task {
            await fetchFixtureStat(fixtureId: fixture.id)
        }
    }
    
    func fetchFixtureStat(fixtureId: String) async {
        do {
            let isDownloaded = try await NetworkManager.shared.fetchData(endpoint: .getFixtureStat(fixtureID: fixtureId))
            if isDownloaded && LiveDataBuffer.upcomingData != nil && !(LiveDataBuffer.upcomingData?.response.isEmpty)!  {
                guard let response = LiveDataBuffer.upcomingData?.response else { return }
                guard let homeTeamStat = response[0].statistics else { return }
                guard let awayTeamStat = response[1].statistics else { return }
                for (index,stat) in homeTeamStat.enumerated() {
                    let type = stat.type ?? ""
                    let homeTeamValue = stat.value?.castValues
                    let awayTeamValue = awayTeamStat[index].value?.castValues
                    var homeTeamText = String(homeTeamValue ?? 0)
                    var awayTeamText = String(awayTeamValue ?? 0)
                    if type == "Ball Possession" || type == "Passes" {
                        if homeTeamValue != -1 || awayTeamValue != -1 {
                            homeTeamText = String(homeTeamValue ?? 0) + "%"
                            awayTeamText = String(awayTeamValue ?? 0) + "%"
                        }
                    }
                    let max = (homeTeamValue ?? 0) + (awayTeamValue ?? 0)
                    self.fixtureStat.append(FixtureStatCellViewModel(type: type,
                                                                     homeTeamValue: homeTeamText,
                                                                     awayTeamValue: awayTeamText,
                                                                     progressHomeTeam: self.addProgress(max: max, progress: homeTeamValue),
                                                                     progressAwayTeam: self.addProgress(max: max, progress: awayTeamValue)))
                }
                if let index = fixtureStat.firstIndex(where: {$0.type == "Ball Possession"}) {
                    ballPossesion = fixtureStat.remove(at: index)
                }
                await reloadData(true)
            } else {
                await reloadData(false)
            }
            }  catch let error {
                print(error)
                await reloadData(false)
            }
            
    }
    
    private func addProgress(max: Int, progress: Int?) -> Float {
        guard let progress = progress else { return 0.0 }
         var floatProgress = Float(progress) / Float(max)
         if floatProgress < 0.1 {
            floatProgress = floatProgress * 10.0
         } else if floatProgress >= 1.0 {
             floatProgress = floatProgress * 0.1
         }
         return floatProgress
     }
}
