//
//  ServiceManager.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchNowPlayingMovies(completionHandler: @escaping (MoviesResult) -> Void)
    func fetchUpcomingMovies(completionHandler: @escaping (MoviesResult) -> Void)
    func fetchSimilarMovies(movieId: Int, completionHandler: @escaping (MoviesResult) -> Void)
    func fetchSearchedMovies(query: String, page: Int, completionHandler: @escaping (MoviesResult) -> Void)
}

struct MovieService: MovieServiceProtocol {
    func fetchSimilarMovies(movieId: Int, completionHandler: @escaping (MoviesResult) -> Void) {
        NetworkManager.shared.request(ServiceRouter.similar(movieId: movieId), decodeToType: BaseReponse.self, completionHandler: completionHandler)
    }

    func fetchNowPlayingMovies(completionHandler: @escaping (MoviesResult) -> Void) {
        NetworkManager.shared.request(ServiceRouter.nowPlaying, decodeToType: BaseReponse.self, completionHandler: completionHandler)
    }

    func fetchUpcomingMovies(completionHandler: @escaping (MoviesResult) -> Void) {
        NetworkManager.shared.request(ServiceRouter.upcoming, decodeToType: BaseReponse.self, completionHandler: completionHandler)
    }

    func fetchSearchedMovies(query: String, page: Int, completionHandler: @escaping (MoviesResult) -> Void) {
        NetworkManager.shared.request(ServiceRouter.search(query: query, page: page),
                                      decodeToType: BaseReponse.self,
                                      completionHandler: completionHandler)
    }
}
