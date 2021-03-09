//
//  Films.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 7.03.21.
//

import Foundation

struct Films: Codable {
    let page: Int?
    let results: [Results]?
    let totalResults: Int?
    let totalPages: Int?
    
    struct Results: Codable {
        let posterPath: String?
        let adult: Bool?
        let overview: String?
        let releaseDate: String?
        let genreIds: [Int]?
        let id: Int?
        let originalTitle: String?
        let originalLanguage: String?
        let title: String?
        let backdropPath: String?
        let popularity: Double?
        let voteCount: Int?
        let video: Bool?
        let voteAverage: Double?
    }
}

extension Films.Results {
    func getYear() -> String {
        guard let stringDate = releaseDate else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: stringDate) else {
            return ""
        }
        
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter.string(from: date)
    }
}
