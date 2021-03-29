//
//  NetworkService.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 7.03.21.
//

import Foundation
import Combine

struct NetworkService {
    
    private struct Constants {
        static let apiKey = "6c447c3bf3a4bdd8000a63ee7dd3ffa7"
        static let popularFilmsUrl = "https://api.themoviedb.org/3/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
    }
    
    static func loadFilms() -> AnyPublisher<[Films.Results], Error> {
        let url = URL(string: Constants.popularFilmsUrl)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Films.self , decoder: decoder)
            .map(\.results)
            .eraseToAnyPublisher()
    }
    
    static func loadSuitableFilms(query: String) -> AnyPublisher<[Films.Results], Error> {
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(Constants.apiKey)&page=1&include_adult=false&language=en-US&query=\(query.lowercased().replacingOccurrences(of: " ", with: ","))")!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Films.self , decoder: decoder)
            .map(\.results)
            .eraseToAnyPublisher()
    }
}
