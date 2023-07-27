//
//  LiveDataBuffer.swift
//  Estrela
//
//  Created by MacBook on 16.01.2023.
//

import Foundation

class LiveDataBuffer {
    static var upcomingData: LiveData?
    static var upcomingDataTeamStat: LiveDataTeamStat?
}

// MARK: - Welcome
struct LiveData: Codable {
    let welcomeGet: String
    let parameters: Parameters
    let errors: [String]?
    let results: Int
    let paging: Paging
    let response: [Response]
    
    enum CodingKeys: String, CodingKey {
        case welcomeGet = "get"
        case parameters, errors, results, paging, response
    }
}

struct LiveDataTeamStat: Codable {
    let welcomeGet: String
    let parameters: Parameters
    let errors: [String]?
    let results: Int
    let paging: Paging
    let response: Response
    
    enum CodingKeys: String, CodingKey {
        case welcomeGet = "get"
        case parameters, errors, results, paging, response
    }
}

// MARK: - Paging
struct Paging: Codable {
    let current, total: Int?
}

// MARK: - Parameters
struct Parameters: Codable {
    let live: String?
}

// MARK: - Response
struct Response: Codable {
    
    let fixture: Fixture?
    let league: League?
    let country: Country?
    let seasons: [Seasons]?
    let teams: Teams?
    let goals: Goals?
    let score: Score?
    let events: [Event]?
    let team: Team?
    let venue: Venue?
    let players: [Players]?
    let player: Player?
    let statistics: [Statistics]?
    let startXI: [StartXI]?
    let substitutes: [StartXI]?
    let formation: String?
    let coach: Coach?
    let name: String?
    //From Team Stat API
    let fixtures: Fixtures?
    let biggest: Biggest?
    let cleanSheet : CleanSheet?
    let failedToScore: FailedToScore?
    let penalty: TeamPenalty?
    let cards: TeamCards?
    //From Events Stat API
    let time : Time?
    let assist : Assist?
    let type : String?
    let detail : String?
    let comments : String?
    let predictions: Predictions?
    
    enum CodingKeys: String, CodingKey {
        case  fixture, league, teams, goals, score, events, team, venue, players,player, statistics, fixtures, biggest, penalty, cards, time, assist, type, detail, comments, startXI, substitutes,formation, country, seasons, name,  coach, predictions
        
        case cleanSheet = "clean_sheet"
        case failedToScore = "failed_to_score"
    }
}

struct Predictions: Codable {
    var percent: Percent
}

struct Percent: Codable {
    var home: String?
    var away: String?
    var draw: String?
}

struct Country: Codable {
    let name: String?
}

struct Seasons: Codable {
    let year: Int
    let current: Bool
    let start: String
    let end: String
}

struct Coach: Codable {
    let name: String
}

// MARK: - Event
struct Event: Codable {
    let time: Time?
    let team: Away?
    let player, assist: Assist?
    let type: TypeEnum?
    let detail: String?
    let comments: String?
}

// MARK: - Assist
struct Assist: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Away
struct Away: Codable {
    let id: Int?
    let name: String?
    let logo: String?
    let winner: Bool?
}

// MARK: - Time
struct Time: Codable {
    let elapsed: Int?
    let extra: Int?
}

enum TypeEnum: String, Codable {
    case card = "Card"
    case goal = "Goal"
    case subst = "subst"
    case typeVar = "Var"
}

// MARK: - Fixture
struct Fixture: Codable {
    let id: Int?
    let referee: String?
    let timezone: String?
    let date: Date?
    let timestamp: Int?
    let periods: Periods?
    let venue: Venue?
    let status: Status?
}

// MARK: - Periods
struct Periods: Codable {
    let first: Int?
    let second: Int?
}

// MARK: - Status
struct Status: Codable {
    let long, short: String?
    let elapsed: Int?
}

// MARK: - Venue
struct Venue: Codable {
    let id: Int?
    let name, city: String?
}

// MARK: - Goals
struct Goals: Codable {
    let home, away: Int?
    let forGoal: TeamGoals?
    let againtsGoal: TeamGoals?
    
    enum CodingKeys: String, CodingKey {
        case home, away
        case forGoal = "for"
        case againtsGoal = "againts"
    }
}

struct TeamGoals: Codable {
    let total: Total?
    let average: Average?
}

struct Total: Codable {
    let home: Int?
    let away: Int?
    let total: Int?
}

struct Average: Codable {
    let home: String?
    let away: String?
    let total: String?
}


// MARK: - League
struct League: Codable {
    let id: Int?
    let name, country: String?
    let logo: String?
    let flag: String?
    let season: Int?
    let round: String?
    let standings: [[Standings]]?
}

struct Standings: Codable {
    let rank : Int?
    let team : Team?
    let points : Int?
    let goalsDiff : Int?
    let all : All?
    let home : All?
    let away : All?
    let description: String?
}

struct All : Codable {
    let played : Int?
    let win : Int?
    let draw : Int?
    let lose : Int?
    let goals : StandingsGoals?
    
    enum CodingKeys: String, CodingKey {
        
        case played = "played"
        case win = "win"
        case draw = "draw"
        case lose = "lose"
        case goals = "goals"
    }
}

struct StandingsGoals: Codable {
    let forGoal: Int?
    let againtsGoal: Int?
    
    enum CodingKeys: String, CodingKey {
        case forGoal = "for"
        case againtsGoal = "againts"
    }
}

// MARK: - Score
struct Score: Codable {
    let halftime, fulltime, extratime, penalty: Goals?
}

// MARK: - Teams
struct Teams: Codable {
    let home, away: Away?
}

struct Team: Codable {
    let id: Int?
    let name: String?
    let logo: String?
    let country: String?
    let founded: Int?
    let code: String?
}

struct Players: Codable {
    let name: String?
    let photo: String?
    let number: Int?
    let id: Int?
    let player: Player?
    let position: String?
    let statistics: [Statistics]?
}

struct Player: Codable, Hashable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    let name: String?
    let photo: String?
    let birth: Birth?
    let id: Int?
    let nationality: String?
    let number: Int?
    let age: Int?
    let lastname: String?
    let height: String?
    let weight: String?
    let pos: String?
}

struct Birth: Codable {
    let date: String?
    let place: String?
    let country: String?
}

struct StartXI: Codable, Hashable {
 
    func hash(into hasher: inout Hasher) {
        hasher.combine(player)
    }
    
    let player: Player?
}


