//
//  TabBarItems.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 14/07/2021.
//

import Foundation
import UIKit

enum TabBarItems {
    
    case home
    case search
    case favorites
    
    var item: UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: L10n.homeTitle,
                                image: Asset.unTappedHome.image,
                                selectedImage: Asset.tappedHome.image.withRenderingMode(.alwaysOriginal))
        case .search:
            return UITabBarItem(title: L10n.searchTitle,
                                image: Asset.unTappedSearch.image,
                                selectedImage: Asset.tappedSearch.image.withRenderingMode(.alwaysOriginal))
        case .favorites:
            return UITabBarItem(title: L10n.favoritesTitle,
                                image: Asset.unTappedFavorites.image,
                                selectedImage: Asset.tappedFavorites.image.withRenderingMode(.alwaysOriginal))
        }
    }
}
