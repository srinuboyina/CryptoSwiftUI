//
//  AppDelegate.swift
//  CryptoCoins
//
//  Created by apple on 29/01/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    func fetchCoins(completion: @escaping (Result<[Coin], Error>) -> Void) {
        guard let url = URL(string: API.baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.addValue(API.apiKey, forHTTPHeaderField: "x-access-token")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("error is \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(CoinResponse.self, from: data)
                print("data is \(decodedData)")
                completion(.success(decodedData.data.coins))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
