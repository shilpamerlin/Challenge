//
//  DataManager.swift
//  Challenge
//
//  Created by Shilpa Joy on 2021-08-29.
//

import Foundation

class DataManager {
    private let serviceProvider = ServiceProvider()
    public func fetchProducts(completion: @escaping ([Products]) -> Void) {
        let request = createURLEndPoint(requestType: ProductEndPoint.listProducts)
        serviceProvider.loadData(request: request, completionHandler: {(data: Results?) in
            guard let productList = data else {return}
            completion(productList.hits)
        })
    }
    
    public func makeProductFavorite(isFav: Bool) {
        var request: ProductEndPoint?
        if isFav {
            request = ProductEndPoint.favourited
        } else {
             request = ProductEndPoint.notFavourited
        }
        let targetRequest = createURLEndPoint(requestType: request!)
        print("\n Favourite endpoint \(targetRequest) and HttpMethod is \(targetRequest.httpMethod!) ")
        serviceProvider.postFavouriteProduct(request:
                        (createURLEndPoint(requestType: request!)), isFavourite: !isFav) { _ in
        }
    }
}
