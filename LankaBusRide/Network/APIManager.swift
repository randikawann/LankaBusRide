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

    func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: endpoint.url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error)); return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData)); return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
