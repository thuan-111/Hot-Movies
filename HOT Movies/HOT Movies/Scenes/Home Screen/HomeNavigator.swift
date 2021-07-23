//
//  HomeNavigator.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import Foundation
import UIKit

protocol HomeNavigatorType {
    func pushToDetails(details: Movie)
}

struct HomeNavigator: HomeNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    func pushToDetails(details: Movie) {
        let viewController = MovieDetailsViewController()
        let useCase = MovieDetailsUseCase(movieRepository: MoviesRepository())
        let viewModel = MovieDetailsViewModel(useCase: useCase, movie: details)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
