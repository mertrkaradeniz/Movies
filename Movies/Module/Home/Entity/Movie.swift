//
//  Movie.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import Foundation

struct Movie: Codable {
    let id: Int?
    let backdropPath: String?
    let imdbID: String?
    let title: String?
    let originalTitle: String?
    let overview: String?
    var posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, overview, title
        case backdropPath = "backdrop_path"
        case imdbID = "imdb_id"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
