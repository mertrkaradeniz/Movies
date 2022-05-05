//
//  Router.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import Foundation
import Alamofire

enum ServiceRouter: URLRequestConvertible {
    case nowPlaying
    case upcoming
    case search(query: String, page: Int)
    case similar(movieId: Int)
    
    var baseURL: URL {
        return URL(string: Constants.BASE_URL)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .nowPlaying, .upcoming, .search, .similar:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        var param: Parameters = [:]
        switch self {
        case .nowPlaying, .upcoming, .similar(movieId: _):
            return nil
        case .search(query: let query, page: let page):
            param["page"] = page
            param["query"] = query
        }
        return param
    }
    
    private var path: String {
        switch self {
        case .nowPlaying:
            return Constants.NOW_PLAYING_MOVIE_URL
        case .upcoming:
            return Constants.UPCMOING_MOVIE_URL
        case .search(query: _, page: _):
            return Constants.SEARCH_MOVIE_URL
        case .similar(movieId: let movieId):
            return "movie/\(movieId)/similar"
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        var completeParameters = parameters ?? [:]
        completeParameters["api_key"] = Constants.API_KEY
        
//        let urlRequestPrint = try encoding.encode(urlRequest, with: completeParameters)
//        debugPrint("final url", urlRequestPrint.url ?? "")
        
        return try encoding.encode(urlRequest, with: completeParameters)
    }
}
