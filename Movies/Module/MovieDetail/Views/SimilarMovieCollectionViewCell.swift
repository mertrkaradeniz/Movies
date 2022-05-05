//
//  SimilarMovieCollectionViewCell.swift
//  Movies
//
//  Created by Mert Karadeniz on 2.05.2022.
//

import UIKit

class SimilarMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(movie: Movie) {
        label.text = movie.title
        let url = URL(string: Constants.IMAGE_BASE_URL_WIDTH_500 + (movie.posterPath ?? ""))
        guard let url = url else { return }
        imageView.setImageRounded(url: url, round: 24)
    }
}
