//
//  HomeViewController.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func prepareTableView()
    func prepareSearchTableView()
    func prepareSearchBar(_ placeholder: String)
    func showNavigationBar(_ animated: Bool)
    func hideNavigationBar(_ animated: Bool)
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
    func searchReloadData()
}

final class HomeViewController: BaseViewController, LoadingShowable {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchTableView: UITableView!

    var presenter: HomePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        presenter?.viewWillDisappear(animated)
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(cellType: MovieTableViewCell.self)
        tableView.register(cellType: SliderTableViewCell.self)
        tableView.accessibilityIdentifier = "tableViewIdentifier"
    }

    func prepareSearchTableView() {
        searchTableView.accessibilityIdentifier = "searchTableViewIdentifier"
        searchTableView.isHidden = true
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        searchTableView.register(cellType: SearchTableViewCell.self)
    }

    func prepareSearchBar(_ placeholder: String) {
        searchBar.delegate = self
        searchBar.setupSearchBar(background: .white, inputText: .darkGray, placeholderText: .darkGray, image: .darkGray)
        searchBar.placeholder = placeholder
    }

    func reloadData() {
        tableView.reloadData()
    }

    func searchReloadData() {
        searchTableView.isHidden = false
        self.searchTableView.reloadData()
    }

    func showLoadingView() {
        showLoading()
    }

    func hideLoadingView() {
        hideLoading()
    }

    func showNavigationBar(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func hideNavigationBar(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return presenter?.numberOfObjects ?? 0
        } else {
            return presenter?.numberOfSearchedMovies ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(with: SliderTableViewCell.self, for: indexPath)
                cell.didSelectItemAt = { [weak self] (index: Int) in
                    guard let self = self else { return }
                    self.presenter?.didSelectSliderRowAt(index: index)
                }
                if let movies = presenter?.getMovie(indexPath.row) as? [Movie] {
                    cell.configure(with: movies)
                }
                return cell
            }
            let cell = tableView.dequeueReusableCell(with: MovieTableViewCell.self, for: indexPath)
            cell.nameLabel.accessibilityIdentifier = "movieCell_\(indexPath.row)"
            if let movie = presenter?.getMovie(indexPath.row) as? Movie {
                cell.presenter = MovieCellPresenter(view: cell, movie: movie)
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(with: SearchTableViewCell.self, for: indexPath)
        cell.accessibilityIdentifier = "searchCell_\(indexPath.row)"
        cell.movieNameLabel.accessibilityIdentifier = "searchCellLabel_\(indexPath.row)"
        cell.configure(with: presenter?.getSearchedMovie(indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView && indexPath.row == 0 {
            return 250.0
        } else if tableView == self.searchTableView {
            return 50.0
        }
        return 160.0
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            presenter?.didSelectRowAt(index: indexPath.row)
        } else {
            presenter?.didSelectSearchRowAt(index: indexPath.row)
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1 {
            presenter?.searchMovies(with: searchText)
        } else {
            searchTableView.isHidden = true
        }
    }
}
