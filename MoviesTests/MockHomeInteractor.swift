//
//  MockHomeInteractor.swift
//  MoviesTests
//
//  Created by Mert Karadeniz on 4.05.2022.
//

@testable import Movies
import UIKit

final class MockHomeInteractor: HomeInteractorProtocol {

    var invokedFetchUpcomingMovies = false
    var invokedFetchUpcomingMoviesCount = 0

    func fetchUpcomingMovies() {
        invokedFetchUpcomingMovies = true
        invokedFetchUpcomingMoviesCount += 1
    }

    var invokedFetchNowPlaying = false
    var invokedFetchNowPlayingCount = 0

    func fetchNowPlaying() {
        invokedFetchNowPlaying = true
        invokedFetchNowPlayingCount += 1
    }

    var invokedFetchSearchedMovies = false
    var invokedFetchSearchedMoviesCount = 0
    var invokedFetchSearchedMoviesParameters: (query: String, page: Int)?
    var invokedFetchSearchedMoviesParametersList = [(query: String, page: Int)]()

    func fetchSearchedMovies(query: String, page: Int) {
        invokedFetchSearchedMovies = true
        invokedFetchSearchedMoviesCount += 1
        invokedFetchSearchedMoviesParameters = (query, page)
        invokedFetchSearchedMoviesParametersList.append((query, page))
    }
}
