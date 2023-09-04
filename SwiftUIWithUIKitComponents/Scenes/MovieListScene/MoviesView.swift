//
//  MoviesView.swift
//  SwiftUIWithUIKitComponents
//
//  Created by magdalena.skawinska on 24/08/2023.
//

import SwiftUI

struct MoviesView: View {
    @StateObject var viewModel = MoviesViewModel()

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    var body: some View {
        NavigationStack {
            List(viewModel.movies, id: \.id) { movie in
                NavigationLink {
                    let detailMovie = DetailMovieModel(id: movie.id,
                                                       title: movie.title,
                                                       description: movie.description,
                                                       posterPath: movie.posterPath,
                                                       releaseDate: .init(wrappedValue: movie.releaseDate ?? nil, dateFormat: "MM/dd/yyyyy"))
                    DetailView(viewModel: DetailViewModel(movie: detailMovie))
                        .background(.black)
                } label: {
                    SwiftUICell(movie: movie)
                        .frame(height: 112)
                }
                .navigationTitle("Movies")

                .navigationBarTitleDisplayMode(.inline)
                .background(.gray.opacity(0.2))
                .listRowBackground(Color.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white, lineWidth: 1)
                )
                .cornerRadius(14)
            }
            .task {
                await viewModel.fetchMovies()
            }
            .background(.black)
            .scrollContentBackground(.hidden)
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
