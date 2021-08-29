//
//  EndPointType.swift
//  Challenge
//
//  Created by Shilpa Joy on 2021-08-28.
//

import Foundation

// HTTPMethodTypes
enum HTTPMethod: String {
    // implement more when needed: post, put, delete etc.
    case get = "GET"
}

/// Protocol to which every Api service should confirm to
protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
   // var parameters: [String: String]? { get}
    var method: HTTPMethod { get }
}
