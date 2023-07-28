//
//  MapViewModel.swift
//  TheBestSports
//
//  Created by MacBook on 28.02.2023.
//

import CoreLocation

struct MapDataViewModel {
    let leagueId: String
    let fixtureId: String
    let coordinates: CLLocationCoordinate2D?
}


class MapViewModel {
    
    var mapDataViewModel: [MapDataViewModel] = []
    var fixtureViewModel: [FixtureCellViewModel] = []
    var downloadedData: ((Bool)->Void) = {_ in }
    
    var mainViewModel = MainViewModel()
    
    func fetchTodaysFixtures() {
        mapDataViewModel.removeAll()
        let group = DispatchGroup()
        Task {
            await mainViewModel.fetchFixturesByDate(date: Date.getToday)
        }
        mainViewModel.reloadData = { isAwailable in
            if isAwailable {
                for item in self.mainViewModel.fixtures {
                    if !self.fixtureViewModel.contains(where: {$0.leagueId == item.leagueId}) {
                        self.fixtureViewModel.append(item)
                    }
                }
                print(self.fixtureViewModel.count)
                self.fixtureViewModel.forEach { fixture in
                        group.enter()
                        self.getCoordinateFrom(address: fixture.city) { coordinate, error in
                            guard let coordinate = coordinate, error == nil else { group.leave(); return }
                            self.mapDataViewModel.append(MapDataViewModel(leagueId: fixture.leagueId,
                                                                          fixtureId: fixture.id,
                                                                          coordinates: coordinate))
                            group.leave()
                    }
                }
            }
            group.notify(queue: .main) {
                if !self.mapDataViewModel.isEmpty {
                    self.downloadedData(true)
                }
            }
        }
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}
