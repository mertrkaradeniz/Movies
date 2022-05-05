//
//  SearchTableViewCell.swift
//  Movies
//
//  Created by Mert Karadeniz on 30.04.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configure(with movie: Movie?) {
        movieNameLabel.text = movie?.title
    }
}
