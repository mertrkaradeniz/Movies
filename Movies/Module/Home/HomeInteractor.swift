//
//  HomeInteractor.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import Foundation

typealias MoviesResult = Result<BaseReponse,Error>
fileprivate var movieService: MovieServiceProtocol = MovieService()

protocol HomeInteractorProtocol: AnyObject {
    func fetchUpcomingMovies()
    func fetchNowPlaying()
    func fetchSearchedMovies(query: String, page: Int)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func fetchNowPlayingMoviesOutput(result: MoviesResult)
    func fetchUpcomingMoviesOutput(result: MoviesResult)
    func fetchSearchedMoviesOutput(result: MoviesResult)
}

final class HomeInteractor: HomeInteractorProtocol {
    var output: HomeInteractorOutputProtocol?
    
    func fetchNowPlaying() {
        movieService.fetchNowPlayingMovies { [weak self] (result) in
            guard let self = self else { return }
            self.output?.fetchNowPlayingMoviesOutput(result: result)
        }
    }
    
    func fetchUpcomingMovies() {
        movieService.fetchUpcomingMovies { [weak self] (result) in
            guard let self = self else { return }
            self.output?.fetchUpcomingMoviesOutput(result: result)
        }
    }
    
    func fetchSearchedMovies(query: String, page: Int) {
        movieService.fetchSearchedMovies(query: query, page: page) { [weak self] (result) in
            guard let self = self else { return }
            self.output?.fetchSearchedMoviesOutput(result: result)
        }
    }
}
