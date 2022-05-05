//
//  SliderCollectionViewCell.swift
//  Movies
//
//  Created by Mert Karadeniz on 28.04.2022.
//

import UIKit

final class SliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!

    func configure(with movie: Movie) {
        movieNameLabel.text = movie.title
        let url = URL(string: Constants.IMAGE_BASE_URL_WIDTH_500 + (movie.backdropPath ?? ""))
        imageView.setImage(url: url)
    }
}
