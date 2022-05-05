//
//  MovieDetailRouter.swift
//  Movies
//
//  Created by Mert Karadeniz on 26.04.2022.
//

import Foundation

enum DetailRoutes {
    case movieDetail(movie: Movie)
}

protocol MovieDetailRouterProtocol: AnyObject {
    func navigate(_ route: DetailRoutes)
}

final class MovieDetailRouter {
    private weak var viewController: MovieDetailViewController?

    static func setupModule() -> MovieDetailViewController {
        let movieDetailVC = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(interactor: interactor, router: router, view: movieDetailVC)

        movieDetailVC.presenter = presenter
        interactor.output = presenter
        router.viewController = movieDetailVC
        return movieDetailVC
    }
}

extension MovieDetailRouter: MovieDetailRouterProtocol {
    func navigate(_ route: DetailRoutes) {
        switch route {
        case .movieDetail(let movie):
            let movieDetailVC = MovieDetailRouter.setupModule()
            movieDetailVC.movie = movie
            viewController?.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
}
