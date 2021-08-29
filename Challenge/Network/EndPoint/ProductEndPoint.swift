//
//  ProductEndPoint.swift
//  Challenge
//
//  Created by Shilpa Joy on 2021-08-28.
//

import Foundation

public enum ProductEndPoint {
    case listProducts
    case favouriteProduct
}

/// confirms to protocol EndPointType
extension ProductEndPoint: EndPointType {
    var baseURL: String {
        return ServiceConstants.baseURL
    }
    var path: String {
        switch self {
        case .listProducts:
            return ServiceConstants.productsAPI
        case .favouriteProduct:
            return ServiceConstants.favouriteAPI
        }
    }
   /* var parameters: [String: String]? {
        /// proviiding default latitude and longitude

        var params: [String: String] = [:]
        switch self {
        case .listProducts:
            params["latitude"] = "37.786882"
            params["longitude"] = "-122.399972"
            return params
        default:
            return nil
        }
    }*/
    
    var method: HTTPMethod {
        switch self {
        case .listProducts, .favouriteProduct:
            return .get
        }
    }
}
