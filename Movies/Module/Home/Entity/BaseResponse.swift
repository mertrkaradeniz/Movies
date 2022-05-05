//
//  BaseResponse.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import Foundation

struct BaseReponse: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages: Int
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
