//
//  NetworkManager.swift
//  Estrela
//
//  Created by MacBook on 16.01.2023.
//


import Foundation
import Alamofire
import UIKit
import Kingfisher

class NetworkManager {
    private let keySDK = "9a49740c5034d7ee252d1e1419a10faa"
    private let url = "https://v3.football.api-sports.io"
    static let shared = NetworkManager()
    
    private func createURL(endpoint: Endpoint) -> URL {
        let url = URL(string: url)
        var urlComponents = URLComponents(url: url!, resolvingAgainstBaseURL: true)
        urlComponents?.path = endpoint.path
        urlComponents?.queryItems = endpoint.query
        return urlComponents!.url!
    }
    
    func fetchData(endpoint: EndpointParameters) async throws -> Bool {
        let header: HTTPHeaders = ["x-rapidapi-key": keySDK]
        let url = createURL(endpoint: endpoint)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        print(url)
        return try await  withCheckedThrowingContinuation({ (continuation: CheckedContinuation<Bool, Error>) in
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: header)
            .validate()
            .responseDecodable(of: LiveData.self, decoder: decoder) { (response) in
                if response.error != nil {
                    continuation.resume(throwing: response.error!)
                    return
                } else {
                    guard let live = response.value else { return }
                    LiveDataBuffer.upcomingData = live
                    continuation.resume(returning: true)
                    return
                }
            }
        })
    }
    
//    func fetchStatTeamData(endpoint: EndpointParameters,completion: @escaping (Bool) -> Void ) {
//        let header: HTTPHeaders = ["x-rapidapi-key": keySDK]
//        let url = createURL(endpoint: endpoint)
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
//        print(url)
//        AF.request(url,
//                   method: .get,
//                   parameters: nil,
//                   encoding: JSONEncoding.default,
//                   headers: header)
//        .validate()
//        .responseDecodable(of: LiveDataTeamStat.self, decoder: decoder) { (response) in
//            guard let live = response.value else { return }
//            LiveDataBuffer.upcomingDataTeamStat = live
//            completion(true)
//        }
//    }
}



