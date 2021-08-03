//
//  MovieDetailsNavigator.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 28/07/2021.
//

import Foundation
import UIKit

protocol MovieDetailsNavigatorType {
    
    func pushToDetails(details: Movie)
    
    func pushYoutube(key: String?)
}

struct MovieDetailsNavigator: MovieDetailsNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    func pushToDetails(details: Movie) {
        let viewController = MovieDetailsViewController()
        let useCase = MovieDetailsUseCase(movieRepository: MoviesRepository(),
                                          favoritesRepository: FavoritesRepository())
        let navigator = MovieDetailsNavigator(navigationController: navigationController)
        let viewModel = MovieDetailsViewModel(useCase: useCase, navigator: navigator, movie: details)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pushYoutube(key: String?) {
        let urlString = MovieURLs.shared.youtubeTrailerPath(key: key ?? "")
        guard let url = URL(string: urlString),
              UIApplication.shared.canOpenURL(url)
        else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
