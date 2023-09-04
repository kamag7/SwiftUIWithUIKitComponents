//
//  Environment.swift
//  SwiftUIWithUIKitComponents
//
//  Created by magdalena.skawinska on 30/08/2023.
//

import Foundation

public enum Environment {
    enum Keys {
        static let apiKey = "API_KEY"
        static let imageBaseUrl = "IMAGE_BASE_URL"
    }

    ///Getting plist here
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()

    ///Get apiKey from plist
    static let apiKey: String = {
        guard let apiKeyString = Environment.infoDictionary[Keys.apiKey] as? String else {
            fatalError("API Key not set in plist")
        }
        return apiKeyString
    }()

    ///Get imageBaseUrl flom plist
    static let imageBaseUrl: String = {
        guard let imageBaseUrl = Environment.infoDictionary[Keys.imageBaseUrl] as? String else {
            fatalError("image base url not set in plist")
        }
        return imageBaseUrl
    }()
}
