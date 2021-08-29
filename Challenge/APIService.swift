//
//  APIService.swift
//  Challenge
//
//  Created by Shilpa Joy on 2021-08-26.
//

import Foundation

class APIService {
    func fetchProducts(closures : @escaping ([Products]) -> Void) {
        let urlString = "https://demo5514996.mockable.io/products"
        let url = URL(string: urlString)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, _, error) in
             if error == nil && data != nil {
                 do {
                     let result = try JSONDecoder().decode(Results.self, from: data!)
                    closures(result.hits)
                 } catch {
                     print("Error in json parcing\(error)")
                 }
             }
         }
         dataTask.resume()
    }
}
