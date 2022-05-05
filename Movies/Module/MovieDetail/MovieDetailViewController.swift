//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Mert Karadeniz on 26.04.2022.
//

import UIKit

protocol MovieDetailViewControllerProtocol: AnyObject {
    func updateUI()
    func prepareCollectionView()
    func setupBackAction()
    func showNavigationBar(animated: Bool)
    func hideNavigationBar(animated: Bool)
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
}

final class MovieDetailViewController: BaseViewController, LoadingShowable {
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var similarMoviesCollectionView: UICollectionView!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var backButton: UIView!

    weak var presenter: MovieDetailPresenterProtocol?
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movieId = movie?.id else { return }
        presenter?.movieId = movieId
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear(animated)
    }
}

extension MovieDetailViewController: MovieDetailViewControllerProtocol {
    func updateUI() {
        let url = URL(string: Constants.IMAGE_BASE_URL_WIDTH_500 + (movie?.backdropPath ?? ""))
        posterImageView.setImage(url: url)
        contentLabel.text = movie?.overview
        titleLabel.text = movie?.title
        rateLabel.text = String(format: "%.1f", movie?.voteAverage ?? 0)
        dateLabel.text = movie?.releaseDate?.dateFormat()
    }

    func prepareCollectionView() {
        similarMoviesCollectionView.delegate = self
        similarMoviesCollectionView.dataSource = self
        similarMoviesCollectionView.register(cellType: SimilarMovieCollectionViewCell.self)
    }

    func setupBackAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        backButton.addGestureRecognizer(tap)
    }

    func showNavigationBar(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func hideNavigationBar(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func reloadData() {
        similarMoviesCollectionView.reloadData()
    }

    func showLoadingView() {
        showLoading()
    }

    func hideLoadingView() {
        hideLoading()
    }

     @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfSimilarMovies ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = similarMoviesCollectionView.dequeCell(cellType: SimilarMovieCollectionViewCell.self, indexPath: indexPath)
        if let movie = presenter?.getSimilarMovie(index: indexPath.row) {
            cell.configure(movie: movie)
        }
        return cell
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        presenter?.collectionViewItemCGSize ?? CGSize()
    }
}
