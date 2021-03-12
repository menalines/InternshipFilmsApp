//
//  NetworkService.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 7.03.21.
//

import Alamofire
import Foundation

struct NetworkService {
    
    private struct Constants {
        static let apiKey = "6c447c3bf3a4bdd8000a63ee7dd3ffa7"
    }
    
    static func loadFilms(successHandler: @escaping ((Films) -> Void), failureHandler: @escaping ((Error) -> Void)) {
        let url = NetworkService.getFilmsDataURL()
        getFilms(from: url, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    static func loadSuitableFilms(query: String, successHandler: @escaping ((Films) -> Void), failureHandler: @escaping ((Error) -> Void)) {
        let url = NetworkService.getSuitableFilmsDataURL(query: query)
        getFilms(from: url, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    private static func getFilms(from url: String, successHandler: @escaping ((Films) -> Void), failureHandler: @escaping ((Error) -> Void)) {
        let request = AF.request(url, method: .get)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        request.responseDecodable(of: Films.self, decoder: decoder, completionHandler: { response in
            if let error = response.error {
                failureHandler(error)
            } else if let films = response.value {
                successHandler(films)
            }
        })
    }
    
    private static func getFilmsDataURL() -> String {
        let url = "https://api.themoviedb.org/3/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
        return url
    }
    
    private static func getSuitableFilmsDataURL(query: String) -> String {
        let url = "https://api.themoviedb.org/3/search/movie?api_key=\(Constants.apiKey)&page=1&include_adult=false&language=en-US&query=\(query.lowercased().replacingOccurrences(of: " ", with: ","))"
        return url
    }
}
