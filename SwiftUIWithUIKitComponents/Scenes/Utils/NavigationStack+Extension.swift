//
//  NavigationStack+Extension.swift
//  SwiftUIWithUIKitComponents
//
//  Created by magdalena.skawinska on 05/09/2023.
//

import SwiftUI

extension NavigationStack {
    func updateForegroundColor(to color: UIColor) -> Self {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: color]
        return self
    }
}
