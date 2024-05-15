//
//  ApiManager.swift
//  products mvvm
//
//  Created by SUMSKAR PC on 11/05/24.
//

import Foundation

import Foundation
enum DataError:Error{
    case invalidUrl
    case invalidData
    case invalidResponse
    case invalidDecoding
    case network(Error?)
}
class ApiManager{
    var products:[Product]=[]
    typealias Handler      = (Result<[Product],DataError>)->Void
    static let shared    = ApiManager()
    
    
    func get(completion: @escaping Handler) {
        let endPoint = "https://fakestoreapi.com/products" // Make sure to use HTTPS
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let decoder = JSONDecoder()
                let products = try decoder.decode([Product].self, from: data)
                print("Products fetched successfully: \(products)")
                completion(.success(products))
            } catch {
                completion(.failure(.invalidDecoding))
            }
        }
        task.resume()
    }

}
