//
//  Service.swift
//  SwiftUIWithUIKitComponents
//
//  Created by magdalena.skawinska on 24/08/2023.
//

import Foundation
import Combine
import TMDb

final class Service {

    static let shared = Service()

    func nowPlaying() async -> [MovieData] {

        let tmdb = TMDbAPI(apiKey: Environment.apiKey)

        do {
            let results = try await tmdb.movies.nowPlaying()

            let movies = results.results.map { item in
                MovieData(id: item.id,
                           title: item.title,
                           overview: item.overview,
                           posterPath: item.posterPath,
                           vote: item.voteAverage,
                           voteCount: item.voteCount,
                           releaseDate: item.releaseDate)
            }
            return movies
        } catch {
            print(error)
            return []
        }
    }
}
