//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit

enum MovieError : Error {
    case requestFailure
    case deserializationError
}

class Network {
    let apiKey = "5885c445eab51c7004916b9c0313e2d3"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private var baseUrl = "https://api.themoviedb.org/3/"
    func getMovies(query : String, completion: @escaping ((Result<[Movie], Error>) -> ())) {

        let queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                          URLQueryItem(name: "query", value: query),
                          URLQueryItem(name: "page", value: "1"),
                          URLQueryItem(name: "include_adult", value: "false")]
        
        var components = URLComponents(string: baseUrl + "search/movie")
        components?.queryItems = queryItems
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        guard let url = components?.url else {
            completion(.failure(MovieError.requestFailure))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                debugPrint(err)
                DispatchQueue.main.async {
                    completion(.failure(MovieError.requestFailure))
                }
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode), let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(MovieError.deserializationError))
                }
                return
            }
            
            var movieResponse: Movies
            do {
                movieResponse = try self.decoder.decode(Movies.self, from: data)
                completion(.success(movieResponse.results ?? []))
            } catch let error {
                debugPrint(error)
                completion(.failure(MovieError.deserializationError))
                return
            }

        }.resume()
    }
    
}
