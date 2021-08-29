//
//  ServiceProvider.swift
//  Challenge
//
//  Created by Shilpa Joy on 2021-08-28.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError: Error {
    case badURL
    case requestFailed
    case unknown
    case decodeFailed
}

/// Class that will actually handle the API calls with a URLSession and resturn response
class ServiceProvider<T: EndPointType> {
    // MARK: - Properties
    var urlSession = URLSession.shared
}

// MARK: - Public funcs
extension ServiceProvider {
    /// Performs API request which is called by any service class
    ///
    /// - Parameters:
    ///     - endPoint: any service that confirms to Service protocol
    ///     - completion: Request completion Handler, will be returning Data
    func loadService(endPoint: T, completion: @escaping(Result<Data>) -> Void) {
        let urlRequest = makeRequest(with: endPoint)
        executeRequest(urlRequest, completion: completion)
    }
    /// Performs API request which is called by any service class
    ///
    /// - Parameters:
    ///     - endPoint: any service that confirms to Service protocol
    ///     - decodeType: decodable object.type
    ///     - completion: Request completion Handler
    func load<U>(
        endPoint: T,
        decodeType: U.Type,
        completion:@escaping(Result<U>)
    -> Void) where U: Decodable {
        let urlRequest = makeRequest(with: endPoint)
        executeRequest(urlRequest) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(decodeType, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decodeFailed))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Private funcs
extension ServiceProvider {
    private func makeRequest(with endPoint: EndPointType) -> URLRequest {
    let urlString = endPoint.baseURL + endPoint.path
        var urlComponents =  URLComponents(string: urlString)
   /* if let parameters =  endPoint.parameters {
        urlComponents?.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
    }*/
        print("URL is \(urlString)")
    guard let url = urlComponents?.url else {
        fatalError("parameters for GET http method must conform to [String: String]")
    }
    var request = URLRequest(url: url)
    request.httpMethod = endPoint.method.rawValue
    // request.setValue("Bearer \(ServiceConstants.apiKey)",
                        // forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return request
}
    private func executeRequest(
        _ request: URLRequest,
        completion:@escaping(Result<Data>)
    -> Void) {
        urlSession.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.requestFailed))
            }
            if let response = response as? HTTPURLResponse {
               if response.statusCode == 200 {
                    if let data = data {
                        // success: send data back
                        completion(.success(data))
                    }
               } else {
                    completion(.failure(.requestFailed))
               }
            }
        }.resume()
    }

    fileprivate func printJSONResponseToConsole(jsonData: Data) {
        if let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
            if let jsonDict = json as? [String: Any] {
                print(jsonDict)
            } else if let jsonArray = json as? [[String: Any]] {
                print(jsonArray)
            } else {
                print("JSON response is neither array nor dictionary")
            }
        } else {
            print("OOPS!!!! it seems like JSON Data is messed up")
        }
    }
}
