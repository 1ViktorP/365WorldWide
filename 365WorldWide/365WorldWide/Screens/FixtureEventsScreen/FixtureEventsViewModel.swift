//
//  FixtureEventsViewModel.swift
//  365WorldWide
//
//  Created by MacBook on 26.07.2023.
//

import Foundation
import UIKit.UIImage

struct EventsCellViewModel {
    let date: Date?
    let homeType: String
    let homeTeamEventIcon: UIImage?
    let homeTeamMinute: String?
    let homeTeamFirstEventName: String
    let homeTeamSecondEventName: String
    let homeTeamIcon: URL?
    let awayType: String
    let awayTeamEventIcon: UIImage?
    let awayTeamMinute: String?
    let awayTeamFirstEventName: String
    let awayTeamSecondEventName: String
    let awayTeamIcon: URL?
}


class FixtureEventsViewModel {
    var events: [EventsCellViewModel] = []
    var fixture: FixtureCellViewModel
    var reloadData: ( @MainActor (Bool)->Void) = { _ in }

    init(fixture: FixtureCellViewModel) {
        self.fixture = fixture
        Task {
            await fetchFixtureEvents(fixtureData: fixture)
        }
    }
    
    func fetchFixtureEvents(fixtureData: FixtureCellViewModel) async {
        do {
            let isDownloaded = try await NetworkManager.shared.fetchData(endpoint: .getFixtureEvents(fixtureID: fixtureData.id))
            if isDownloaded && LiveDataBuffer.upcomingData != nil && !(LiveDataBuffer.upcomingData?.response.isEmpty)!  {
                guard var response = LiveDataBuffer.upcomingData?.response else { return }
                response.sort(by: {$0.time?.elapsed ?? 0 > $1.time?.elapsed ?? 0})
                response.forEach { response in
                    var preficsForSecondEvent = ""
                    var preficsForFirstEvent = ""
                    if response.type == "Card" {
                        preficsForSecondEvent = "Foul"
                    } else if response.type == "subst" {
                        preficsForFirstEvent = "In : "
                        preficsForSecondEvent = "Out : "
                    }
                    if response.team?.name == fixtureData.homeTeamName {
                        let icon = self.checkTypeAndGetIcon(type: response.type ?? "",
                                                            detailType: response.detail ?? "")
                        events.append(EventsCellViewModel(date: response.fixture?.date ,
                                                           homeType: response.type ?? "",
                                                           homeTeamEventIcon: icon,
                                                           homeTeamMinute: String(response.time?.elapsed ?? 0),
                                                           homeTeamFirstEventName: preficsForFirstEvent + (response.player?.name ?? ""),
                                                           homeTeamSecondEventName: preficsForSecondEvent + (response.assist?.name ?? ""),
                                                           homeTeamIcon: fixtureData.homeTeamIcon,
                                                           awayType: "",
                                                           awayTeamEventIcon: nil,
                                                           awayTeamMinute: "",
                                                           awayTeamFirstEventName: "",
                                                           awayTeamSecondEventName: "",
                                                           awayTeamIcon: nil))
                    } else if response.team?.name == fixtureData.awayTeamName {
                        let icon = self.checkTypeAndGetIcon(
                            type: response.type ?? "",
                            detailType: response.detail ?? "")
                        events.append(EventsCellViewModel(date: nil,
                                                           homeType: "",
                                                           homeTeamEventIcon:nil,
                                                           homeTeamMinute: "",
                                                           homeTeamFirstEventName: "",
                                                           homeTeamSecondEventName: "",
                                                           homeTeamIcon: nil,
                                                           awayType: response.type ?? "",
                                                           awayTeamEventIcon: icon,
                                                           awayTeamMinute: String(response.time?.elapsed ?? 0),
                                                           awayTeamFirstEventName: preficsForFirstEvent + (response.player?.name ?? ""),
                                                           awayTeamSecondEventName: preficsForSecondEvent + (response.assist?.name ?? ""),
                                                           awayTeamIcon: fixtureData.awayTeamIcon))
                    }
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
    
    private func checkTypeAndGetIcon(type: String, detailType: String) -> UIImage? {
        if type == "subst" {
            return UIImage(named: "substituIcon")
        } else if type == "Card" {
            if detailType == "Yellow Card" || detailType == "Second Yellow card" {
                return UIImage(named: "yellowCard")
            } else {
                return UIImage(named: "redCard")
            }
        } else if type == "Goal" {
            if detailType == "Normal Goal" || detailType == "Own Goal" {
                return UIImage(named: "ball")
            } else if detailType == "Penalty" {
                return UIImage(named: "penalty")
            } else if detailType == "Missed Penalty" {
                return UIImage(named: "penalty")?.withTintColor(.red)
            }
        } else {
            return nil
        }
        return nil
    }
}
