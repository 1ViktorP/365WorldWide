//
//  Statistics.swift
//  Estrela
//
//  Created by MacBook on 18.01.2023.
//

import Foundation

struct Statistics: Codable {
    let team: Team?
    let games : Games?
    let substitutes : Substitutes?
    let shots : Shots?
    let goals : GoalsPlayer?
    let passes : Passes?
    let tackles : Tackles?
    let duels : Duels?
    let dribbles : Dribbles?
    let fouls : Fouls?
    let cards : Cards?
    let penalty : Penalty?
   //Fof Game Stat
    let type : String?
    let value : Value?
    
    
    enum CodingKeys: String, CodingKey {
        case games = "games"
        case substitutes = "substitutes"
        case shots = "shots"
        case goals = "goals"
        case passes = "passes"
        case tackles = "tackles"
        case duels = "duels"
        case dribbles = "dribbles"
        case fouls = "fouls"
        case cards = "cards"
        case penalty = "penalty"
        case type
        case value
        case team
    }
}

enum Value: Codable {
    case string(String)
    case int(Int)
    
    init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            if let x = try? container.decode(Int.self) {
                self = .int(x)
                return
            }
            throw DecodingError.typeMismatch(Value.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Values"))
        }
    
    var castValues: Int {
        switch self {
        case .string(var string):
            if string.contains(where: {$0 == "%"}) {
                string.removeLast()
            }
            return Int(string) ?? -1
        case .int(let int):
            return int
        }
    }
}

struct Cards: Codable {
    let yellow : Int?
    let yellowred : Int?
    let red : Int?
}

struct Dribbles: Codable {
    let attempts : Int?
    let success : Int?
    let past : Int?
}

struct Duels: Codable {
    let total : Int?
    let won : Int?
}
struct Fouls: Codable {
    let drawn : Int?
    let committed : Int?
}

struct Games: Codable {
    let appearences : Int?
    let lineups : Int?
    let minutes : Int?
    let position : String?
    let rating : String?
}

struct GoalsPlayer: Codable {
    let total : Int?
    let conceded : Int?
    let assists : Int?
    let saves : Int?
}

struct Passes: Codable {
    let total : Int?
    let key : Int?
    let accuracy : Accuracy?
}

enum Accuracy: Codable {
    case string(String)
    case int(Int)
    
    init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            if let x = try? container.decode(Int.self) {
                self = .int(x)
                return
            }
            throw DecodingError.typeMismatch(Value.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Values"))
        }
    
    var castValues: String {
        switch self {
        case .string(let string):
            return string
        case .int(let int):
            return String(int)
        }
    }
}

struct Penalty : Codable {
    let won : Int?
    let commited : Int?
    let scored : Int?
    let missed : Int?
    let saved : Int?
}

struct Substitutes : Codable {
    let _in : Int?
    let out : Int?
    let bench : Int?
  
    enum CodingKeys: String, CodingKey {
        case _in = "in"
        case out = "out"
        case bench = "bench"
    }
}

struct Tackles : Codable {
    let total : Int?
    let blocks : Int?
    let interceptions : Int?
}

struct Shots : Codable {
    let total : Int?
    let on : Int?
}
