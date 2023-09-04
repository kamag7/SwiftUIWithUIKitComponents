//
//  ImageRequestUrl.swift
//  SwiftUIWithUIKitComponents
//
//  Created by magdalena.skawinska on 24/08/2023.
//

import Foundation


final class ImageRequestUrl {
    static func imageURL(imageStringUrl: URL?) -> URL? {
        guard let imageUrl = imageStringUrl else {
            return nil
        }

        return URL(string: Environment.imageBaseUrl.trimmingCharacters(in: .punctuationCharacters) + imageUrl.absoluteString)
    }
}
