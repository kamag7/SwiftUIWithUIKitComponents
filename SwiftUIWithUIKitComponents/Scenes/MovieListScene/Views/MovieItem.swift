//
//  UIKitCell.swift
//  SwiftUIWithUIKitComponents
//
//  Created by magdalena.skawinska on 25/08/2023.
//

import Foundation
import UIKit
import SwiftUI
import Nuke
import NukeExtensions

class MovieItem: UIView {
    private let pipeline = ImagePipeline.shared
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "film")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.lineBreakMode = .byTruncatingTail

        return label
    }()

    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail

        return label
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .yellow
        stackView.spacing = 3
        stackView.backgroundColor = .clear
        stackView.autoresizesSubviews = true
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    init(movie: MovieModel) {
        super.init(frame: .zero)
        setupSubviews()
        let urlStringImagePath = ImageRequestUrl.imageURL(imageStringUrl: movie.posterPath)
        configure(title: movie.title, subtitle: movie.description, url: urlStringImagePath)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.preferredMaxLayoutWidth = frame.size.width - 92
        subTitleLabel.preferredMaxLayoutWidth =  frame.size.width - 92
    }
    private func setupSubviews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80)
        ])

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)

        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 16),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func configure(imageString: String? = nil, title: String, subtitle: String? = nil, url: URL?) {
        titleLabel.text = title
        subTitleLabel.text = subtitle
        if let url {
            loadImage(imageView: imageView, url: url, processors: [])
        }
    }

    private func loadImage(imageView: UIImageView, url: URL, processors: [ImageProcessing]) {
        let request = ImageRequest(
            url: url,
            processors: processors
        )

        var options = ImageLoadingOptions(transition: .fadeIn(duration: 0.5))
        options.pipeline = pipeline

        NukeExtensions.loadImage(with: request, options: options, into: imageView)
    }
}

struct MovieItemView: UIViewRepresentable {

    var movieItem: MovieItem
    init(movie: MovieModel) {
        movieItem = MovieItem(movie: movie)
    }

    func makeUIView(context: Context) -> MovieItem {
        return movieItem
    }

    func updateUIView(_ uiView: MovieItem, context: Context) { }

    typealias UIViewType = MovieItem
}
