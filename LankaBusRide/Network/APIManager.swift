//
//  APIManager.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

final class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func request<T: Decodable>(
        endpoint: Endpoint,
        completion: @escaping (Bool, T?, NetworkError?) -> ()
    ) {
        guard let url = URL(string: endpoint.url) else {
            completion(false, nil, .invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(false, nil, .custom(error))
                return
            }
            
            guard let data = data else {
                completion(false, nil, .noData)
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(true, decoded, nil)
            } catch {
                completion(false, nil, .decodingError)
            }
        }.resume()
    }
}
