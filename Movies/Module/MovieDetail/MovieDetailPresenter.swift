//
//  MovieDetailPresenter.swift
//  Movies
//
//  Created by Mert Karadeniz on 26.04.2022.
//

import UIKit

protocol MovieDetailPresenterProtocol: AnyObject {
    var movieId: Int? { get set }
    var numberOfSimilarMovies: Int { get }
    var collectionViewItemCGSize: CGSize { get }
    
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func didSelectRowAt(index: Int)
    func getSimilarMovie(index: Int) -> Movie?
}

final class MovieDetailPresenter {
    private weak var view: MovieDetailViewControllerProtocol?
    private let router: MovieDetailRouterProtocol?
    private let interactor: MovieDetailInteractorProtocol?
    private var similarMovies: [Movie] = []
    var movieId: Int? = 0
    
    init(interactor: MovieDetailInteractorProtocol,
         router: MovieDetailRouterProtocol,
         view:  MovieDetailViewControllerProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    var numberOfSimilarMovies: Int {
        similarMovies.count
    }
    
    var collectionViewItemCGSize: CGSize {
        CGSize(width: 120.0, height: 230.0)
    }

    func viewDidLoad() {
        view?.updateUI()
        view?.prepareCollectionView()
        view?.setupBackAction()
        interactor?.fetchSimilarMovie(movieId: movieId!)
    }
    
    func viewWillAppear(_ animated: Bool) {
        view?.hideNavigationBar(animated: animated)
    }
    
    func viewWillDisappear(_ animated: Bool) {
        view?.showNavigationBar(animated: animated)
    }
    
    func didSelectRowAt(index: Int) {
        guard let movie = getSimilarMovie(index: index) else { return }
        router?.navigate(.movieDetail(movie: movie))
    }
    
    func getSimilarMovie(index: Int) -> Movie? {
        similarMovies[safe: index]
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func fetchSimilarMovieOutput(result: MoviesResult) {
        switch result {
        case .success(let moviesResult):
            similarMovies = moviesResult.results!
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
}

