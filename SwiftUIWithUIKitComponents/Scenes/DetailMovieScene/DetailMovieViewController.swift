//
//  DetailMovieViewController.swift
//  SwiftUIWithUIKitComponents
//
//  Created by magdalena.skawinska on 29/08/2023.
//

import Foundation
import UIKit
import SwiftUI
import Nuke
import NukeExtensions

final class DetailMovieViewController: UIViewController {

    var viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray.withAlphaComponent(0.2)
        setupSubview()
        configureView(title: viewModel.movie.title,
                      releaseString: viewModel.movie.$releaseDate,
                      description: viewModel.movie.description)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .never

        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16

        return stackView
    }()

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "film")
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .white
        imageView.sizeToFit()

        return imageView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = . byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private func setupSubview() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(releaseDateLabel)
        stackView.addArrangedSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 500)
        ])

        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func configureView(title: String, releaseString: String?, description: String?) {
        titleLabel.text = title
        releaseDateLabel.text = releaseString
        descriptionLabel.text = description
        if let url = ImageRequestUrl.imageURL(imageStringUrl: viewModel.movie.posterPath) {
            loadImage(imageView: imageView, url: url)
        }
    }

    private func loadImage(imageView: UIImageView, url: URL){
        let request = ImageRequest(url: url)
        let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.2))
        NukeExtensions.loadImage(with: request, options: options, into: imageView)
    }
}

struct DetailView: UIViewControllerRepresentable {
    typealias UIViewControllerType = DetailMovieViewController
    var viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }

    func makeUIViewController(context: Context) -> DetailMovieViewController {
        let detailMovieViewController = DetailMovieViewController(viewModel: viewModel)
        return detailMovieViewController
    }

    func updateUIViewController(_ uiViewController: DetailMovieViewController, context: Context) { }
}
