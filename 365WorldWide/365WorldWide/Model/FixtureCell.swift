//
//  FixtureCell.swift
//  SportUs
//
//  Created by MacBook on 12.06.2023.
//

import Foundation

struct FixtureCellViewModel: Codable {
    let homeTeamIcon: URL?
    let homeTeamName: String
    let homeTeamScore: String
    let awayTeamIcon: URL?
    let awayTeamName: String
    let awayTeamScore: String
    let status: String
    let dateStr: String
    let isFavorite: Bool
    let id: String
    let date: Date
    let leagueId: String
    let leagueName: String
    let homeTeamId: String
    let awayTeamId: String
    let minute: String
    let city: String
    let country: String
    var season: Int = 0
}

struct LeaguesList: Codable {
    let name: String
    let leagueId: String
    let lastSeason: String
}

struct Prediction: Codable {
    let fixtureId: String
    let isHomeWin: Bool
    var isWinResultPredicted: Bool?
    var calculatedProgress = false
}

struct Progress: Codable {
        var total: Int
        var wins: Int
        var lose: Int
}
