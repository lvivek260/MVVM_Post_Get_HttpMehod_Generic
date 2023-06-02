//
//  APIManager.swift
//  Post_Get_Generic_API_MVVM
//
//  Created by Mac on 17/05/23.
//

import Foundation

typealias Handler<T> = (Result<T, FetchingError>)->Void

final class APIManager{
    static let shared = APIManager()
    private init(){}
    let commonAPIHeader = ["Content-Type": "application/json"]
    
    func fetchData<T: Codable>(
        model: T.Type,
        type: EndPointItems,
        completion: @escaping Handler<T>
    ){
        guard let url = type.url else {
            completion(.failure(.invalidUrl))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = type.httpMethod.rawValue
        if let parameter = type.body {
            request.httpBody = try? JSONEncoder().encode(parameter as? T)
            request.allHTTPHeaderFields = type.headers
        }
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
            200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
           
            do{
                let apiData = try JSONDecoder().decode(model, from: data)
                completion(.success(apiData))
            }
            catch let err{
                completion(.failure(.decodingError(err)))
            }
        }.resume()
    }
}

enum FetchingError: Error{
    case invalidUrl
    case invalidData
    case invalidResponse
    case decodingError(Error)
}

enum Event{
    case startLoading
    case stopLoading
    case reloadData
    case error(FetchingError)
}
