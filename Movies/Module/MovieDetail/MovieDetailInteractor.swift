//
//  MovieDetailInteractor.swift
//  Movies
//
//  Created by Mert Karadeniz on 26.04.2022.
//

import Foundation

typealias MovieResult = Result<Movie, Error>
private var movieService: MovieServiceProtocol = MovieService()

protocol MovieDetailInteractorProtocol: AnyObject {
    func fetchSimilarMovie(movieId: Int)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    func fetchSimilarMovieOutput(result: MoviesResult)
}

final class MovieDetailInteractor: MovieDetailInteractorProtocol {
    var output: MovieDetailInteractorOutputProtocol?

    func fetchSimilarMovie(movieId: Int) {
        movieService.fetchSimilarMovies(movieId: movieId) { result in
            self.output?.fetchSimilarMovieOutput(result: result)
        }
    }
}
