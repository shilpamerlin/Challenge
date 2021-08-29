//
//  ServiceProvider.swift
//  Challenge
//
//  Created by Shilpa Joy on 2021-08-28.
//

import Foundation

/// Class that will actually handle the API calls with a URLSession and resturn response
class ServiceProvider {
    static let shared = ServiceProvider()

    /// Performs API request
    func loadData <T: Decodable> (request: URLRequest, completionHandler: @escaping((T?) -> Void)) {
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            guard let data = data, error == nil  else {
                print("Unable to reach server, error occured\(String(describing: error?.localizedDescription))")
                return
            }
            do {
                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 200:
                            let result = try JSONDecoder().decode(T.self, from: data)
                            DispatchQueue.main.async {
                                completionHandler(result)
                            }
                    default:
                            break
                        }
                    }
                } catch {
                    print("Network error occured.. \(error.localizedDescription)")
                    completionHandler(nil)
                    }
        }).resume()
    }
    
    func postFavouriteProduct(request: URLRequest, isFavourite: Bool, completion: (Error?) -> Void) {
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            print("POST to favourite endpoint done!! \(String(data: data, encoding: .utf8) ?? "")")
        }.resume()
    }
}
