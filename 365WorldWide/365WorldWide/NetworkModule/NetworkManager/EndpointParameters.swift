//
//  EndpointParameters.swift
//  Estrela
//
//  Created by MacBook on 16.01.2023.
//

import Foundation

enum EndpointParameters: Endpoint {
    
    case leagueList(id: String)
    case getFixturesByDate(date: String)
    case getStandings(leagueId: String, season: String)
    case getFixturesByLeague(id: String,date: String, season: String)
    case getFixture(id: String)
    case getTeam(id: String)
    case getTeamSquad(id: String)
    case getPlayer(id: String, season: String)
    case getTeamStatistics(leageID: String, teamID: String, season: String)
    case getFixtureStat(fixtureID: String)
    case getFixtureEvents(fixtureID: String)
    case getFixturePlayers(fixtureID: String)
    case getFixtureH2H(h2h: String)
    case getLineUp(fixtureId: String)
    case getCoach(teamId: String)
    case getPrediction(fixtureId: String)
    case leagues(season: String)
    
    
    var path: String {
        switch self {
        case .leagueList:
            return "/leagues"
        case .getFixturesByLeague, .getFixture, .getFixturesByDate:
            return "/fixtures"
        case .getTeam:
            return "/teams"
        case .getTeamSquad:
            return "/players/squads"
        case .getPlayer:
            return "/players"
        case .getTeamStatistics:
            return "/teams/statistics"
        case .getFixtureStat:
            return "/fixtures/statistics"
        case .getFixtureEvents:
            return  "/fixtures/events"
        case .getFixturePlayers:
            return "/fixtures/players"
        case .getFixtureH2H:
            return "/fixtures/headtohead"
        case .getLineUp:
            return "/fixtures/lineups"
        case .getStandings:
            return "/standings"
        case .getCoach:
            return "/coachs"
        case .getPrediction:
            return "/predictions"
        case .leagues:
            return "/leagues"
        }
    }
    
    var query: [URLQueryItem] {
        var queryItem: [URLQueryItem] = []
        switch self {
        case .leagueList(id: let id):
            queryItem.append(URLQueryItem(name: "id", value: id))
            queryItem.append(URLQueryItem(name: "current", value: "true"))
            return queryItem
        case .getFixturesByLeague(id: let id, date: let date, season: let season):
            queryItem.append(URLQueryItem(name: "league", value: id))
            queryItem.append(URLQueryItem(name: "date", value: date))
            queryItem.append(URLQueryItem(name: "season", value: season))
            return queryItem
        case .getFixture(id: let id) ,.getTeam(id: let id):
            queryItem.append(URLQueryItem(name: "id", value: id))
            return queryItem
        case .getPlayer(id: let id, season: let season):
            queryItem.append(URLQueryItem(name: "id", value: id))
            queryItem.append(URLQueryItem(name: "season", value: season))
            return queryItem
        case .getTeamSquad(id: let id):
            queryItem.append(URLQueryItem(name: "team", value: id))
            return queryItem
        case .getTeamStatistics(leageID: let leageID, teamID: let teamID, season: let season):
            queryItem.append(URLQueryItem(name: "league", value: leageID))
            queryItem.append(URLQueryItem(name: "team", value: teamID))
            queryItem.append(URLQueryItem(name: "season", value: season))
            return queryItem
        case .getFixtureStat(fixtureID: let fixtureID):
            queryItem.append(URLQueryItem(name: "fixture", value: fixtureID))
            return queryItem
        case .getFixtureEvents(fixtureID: let fixtureID):
            queryItem.append(URLQueryItem(name: "fixture", value: fixtureID))
            return queryItem
        case .getFixturePlayers(fixtureID: let fixtureID):
            queryItem.append(URLQueryItem(name: "fixture", value: fixtureID))
            return queryItem
        case .getFixtureH2H(h2h: let h2h):
            queryItem.append(URLQueryItem(name: "h2h", value: h2h))
            queryItem.append(URLQueryItem(name: "from", value: "2018-01-01"))
            queryItem.append(URLQueryItem(name: "to", value: "2025-01-01"))
           // queryItem.append(URLQueryItem(name: "last", value: "20"))
            //queryItem.append(URLQueryItem(name: "next", value: "5"))
            return queryItem
        case .getLineUp(fixtureId: let fixtureId):
            queryItem.append(URLQueryItem(name: "fixture", value: fixtureId))
            return queryItem
        case .getStandings(leagueId: let leagueId, season: let season):
            queryItem.append(URLQueryItem(name: "league", value: leagueId))
            queryItem.append(URLQueryItem(name: "season", value: season))
            return queryItem
        case .getCoach(teamId: let teamId):
            queryItem.append(URLQueryItem(name: "team", value: teamId))
            return queryItem
        case .getPrediction(fixtureId: let fixtureId):
            queryItem.append(URLQueryItem(name: "fixture", value: fixtureId))
            return queryItem
        case .leagues(season: let season):
            queryItem.append(URLQueryItem(name: "current", value: "true"))
            queryItem.append(URLQueryItem(name: "season", value: season))
            return queryItem
        case .getFixturesByDate(date: let date):
            queryItem.append(URLQueryItem(name: "date", value: date))
            return queryItem
        }
    }
}
