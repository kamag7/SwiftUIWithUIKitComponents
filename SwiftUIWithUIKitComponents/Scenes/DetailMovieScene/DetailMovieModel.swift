//
//  DetailMovieModel.swift
//  SwiftUIWithUIKitComponents
//
//  Created by magdalena.skawinska on 30/08/2023.
//

import Foundation
struct DetailMovieModel {
    let id: Int
    let title: String
    let description: String?
    let posterPath: URL?
    @FormattedDate var releaseDate: Date?
}

@propertyWrapper struct FormattedDate {
    private var dateFormat: String
    var wrappedValue: Date?
    var projectedValue: String? {
        get {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.dateFormat = dateFormat
            guard let date = wrappedValue else { return nil }
            return formatter.string(from: date)
        }
    }
    init(wrappedValue: Date?, dateFormat: String) {
        self.wrappedValue = wrappedValue
        self.dateFormat = dateFormat
    }
}
