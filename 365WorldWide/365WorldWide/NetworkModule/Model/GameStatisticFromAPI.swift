//
//  GameStatistic.swift
//  Estrela
//
//  Created by MacBook on 23.01.2023.
//

import Foundation

struct Fixtures: Codable {
    let played: Played?
    let wins: Wins?
    let draws: Draws?
    let loses: Loses?
}

struct Played: Codable {
    let home: Int?
    let away: Int?
    let total: Int?
}

struct Wins: Codable {
    let home: Int?
    let away: Int?
    let total: Int?
}

struct Draws: Codable {
    let home: Int?
    let away: Int?
    let total: Int?
}

struct Loses: Codable {
    let home: Int?
    let away: Int?
    let total: Int?
}

struct Streak : Codable {
    let wins : Int?
    let draws : Int?
    let loses : Int?
}

struct Biggest: Codable {
    let streak : Streak?
    let wins : StatBiggest?
    let loses : StatBiggest?
}

struct StatBiggest: Codable {
    let home: String?
    let away: String?
}


struct CleanSheet: Codable {
    let home : Int?
    let away : Int?
    let total : Int?
}

struct FailedToScore: Codable {
    let home : Int?
    let away : Int?
    let total : Int?
}

struct TeamPenalty: Codable {
    let scored: PenaltyStat
    let missed: PenaltyStat
}

struct PenaltyStat: Codable {
    let total: Int
}

struct TeamCards: Codable {
    let yellow: CardStat
    let red: CardStat
}

struct CardStat : Codable {
    let first : TimeCards?
    let second : TimeCards?
    let third : TimeCards?
    let fourth : TimeCards?
    let fifth : TimeCards?
    let sixth : TimeCards?
    let seventh : TimeCards?
    let eighth : TimeCards?
    
    enum CodingKeys: String, CodingKey {
        
        case first = "0-15"
        case second = "16-30"
        case third = "31-45"
        case fourth = "46-60"
        case fifth = "61-75"
        case sixth = "76-90"
        case seventh = "91-105"
        case eighth = "106-120"
    }
    
    var totalCards: Int {
        let firstPart = (first?.total ?? 0) + (second?.total ?? 0)
        let secondPart = (third?.total ?? 0) + (fourth?.total ?? 0)
        let thirdPart = (fifth?.total ?? 0) + (sixth?.total ?? 0)
        let fourthPart = (seventh?.total ?? 0) + (eighth?.total ?? 0)
        return firstPart + secondPart + thirdPart + fourthPart
    }
}

struct TimeCards : Codable {
    let total : Int?
}



