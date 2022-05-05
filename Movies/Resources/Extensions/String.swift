//
//  String.swift
//  Movies
//
//  Created by Mert Karadeniz on 2.05.2022.
//

import Foundation

extension String {
    func dateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        guard let formattedDate = formattedDate else { return "" }
        return dateFormatter.string(from: formattedDate).replacingOccurrences(of: "-", with: ".")
    }
}
