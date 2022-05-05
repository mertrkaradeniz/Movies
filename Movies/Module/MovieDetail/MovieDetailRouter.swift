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
    weak var viewController: MovieDetailViewController?
    
    static func setupModule() -> MovieDetailViewController {
        let vc = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(interactor: interactor, router: router, view: vc)
        
        vc.presenter = presenter
        interactor.output = presenter
        router.viewController = vc
        return vc
    }
}

extension MovieDetailRouter: MovieDetailRouterProtocol {
    func navigate(_ route: DetailRoutes) {
        switch route {
        case .movieDetail(let movie):
            let vc = MovieDetailRouter.setupModule()
            vc.movie = movie
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
