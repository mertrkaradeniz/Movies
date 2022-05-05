//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Mert Karadeniz on 26.04.2022.
//

import UIKit
import Kingfisher

protocol MovieCellProtocol: AnyObject {
    func setMovieImageView(_ url: URL?)
    func setNameLabel(_ text: String)
    func setDescriptionLabel(_ text: String)
    func setDateLabel(_ text: String)
}

final class MovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    var presenter: MovieCellPresenterProtocol? {
        didSet {
            presenter?.load()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }
}

extension MovieTableViewCell: MovieCellProtocol {
    func setMovieImageView(_ url: URL?) {
        imageView?.setImageRounded(url: url, round: 8)
    }

    func setNameLabel(_ text: String) {
        nameLabel.text = text
    }

    func setDescriptionLabel(_ text: String) {
        descriptionLabel.text = text
    }

    func setDateLabel(_ text: String) {
        dateLabel.text = text.dateFormat()
    }
}
