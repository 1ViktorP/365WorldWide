//
//  Endpoint.swift
//  Estrela
//
//  Created by MacBook on 16.01.2023.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var query: [URLQueryItem] { get }
}
