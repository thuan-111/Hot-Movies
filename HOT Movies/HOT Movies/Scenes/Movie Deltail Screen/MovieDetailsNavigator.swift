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
}

struct MovieDetailsNavigator: MovieDetailsNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    func pushToDetails(details: Movie) {
        let viewController = MovieDetailsViewController()
        let useCase = MovieDetailsUseCase(movieRepository: MoviesRepository())
        let navigator = MovieDetailsNavigator(navigationController: navigationController)
        let viewModel = MovieDetailsViewModel(useCase: useCase, navigator: navigator, movie: details)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
