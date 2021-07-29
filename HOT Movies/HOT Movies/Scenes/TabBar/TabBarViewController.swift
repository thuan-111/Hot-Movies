//
//  TabBarViewController.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 14/07/2021.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configuewViews()
    }
    
    func configuewViews() {
        tabBar.do {
            $0.barTintColor = UIColor.white
            $0.clipsToBounds = true
        }
        
        viewControllers = [
            createHomeNavigationController(),
            createSearchNavigationController(),
            createFavoritesNavigationController()
        ]
    }
    
    func configureNavigationController(viewController: UIViewController, item: UITabBarItem) -> UINavigationController {
        let navigationController = BaseNavigationController(rootViewController: viewController)
        viewController.tabBarItem = item
        return navigationController
    }
    
    func createHomeNavigationController() -> UINavigationController {
        let viewController = HomeViewController()
        viewController.tabBarItem = TabBarItems.home.item
        let useCase = HomeUseCase(moviesRepository: MoviesRepository())
        let navigationController = BaseNavigationController(rootViewController: viewController)
        let navigator = HomeNavigator(navigationController: navigationController)
        let viewModel = HomeViewModel(navigator: navigator, useCase: useCase)
        viewController.bindViewModel(to: viewModel)
        return navigationController
    }
    
    func createSearchNavigationController() -> UINavigationController {
        let viewController = SearchViewController()
        viewController.tabBarItem = TabBarItems.search.item
        let useCase = SearchUseCase(moviesRepository: MoviesRepository())
        let navigationController = BaseNavigationController(rootViewController: viewController)
        let navigator = SearchNavigator(navigationController: navigationController)
        let viewModel = SearchViewModel(navigator: navigator, useCase: useCase)
        viewController.bindViewModel(to: viewModel)
        return navigationController
    }
    
    func createFavoritesNavigationController() -> UINavigationController {
        let viewController = FavoritesViewController()
        viewController.tabBarItem = TabBarItems.favorites.item
        let navigationController = BaseNavigationController(rootViewController: viewController)
        viewController.tabBarItem = TabBarItems.favorites.item
        let useCase = FavoritesUseCase(favoritesRepository: FavoritesRepository())
        let navigator = FavoritesNavigator(navigationController: navigationController)
        let viewModel = FavoritesViewModel(navigator: navigator, useCase: useCase)
        viewController.bindViewModel(to: viewModel)
        return navigationController
    }
}
