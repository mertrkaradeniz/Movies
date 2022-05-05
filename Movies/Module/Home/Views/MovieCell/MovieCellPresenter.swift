//
//  MovieCellPresenter.swift
//  Movies
//
//  Created by Mert Karadeniz on 26.04.2022.
//

import Foundation

protocol MovieCellPresenterProtocol: AnyObject {
    func load()
}

final class MovieCellPresenter {
    private weak var view: MovieCellProtocol?
    private let movie: Movie

    init(view: MovieCellProtocol, movie: Movie) {
        self.view = view
        self.movie = movie
    }
}

extension MovieCellPresenter: MovieCellPresenterProtocol {
    func load() {
        if let posterPath = movie.posterPath {
            let url = URL(string: Constants.IMAGE_BASE_URL_WIDTH_92 + posterPath)
            view?.setMovieImageView(url)
        }
        view?.setNameLabel(movie.title ?? "")
        view?.setDescriptionLabel(movie.overview ?? "")
        view?.setDateLabel(movie.releaseDate ?? "")
    }
}
