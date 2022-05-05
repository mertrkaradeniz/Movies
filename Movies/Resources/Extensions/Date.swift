//
//  Date.swift
//  Movies
//
//  Created by Mert Karadeniz on 2.05.2022.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
