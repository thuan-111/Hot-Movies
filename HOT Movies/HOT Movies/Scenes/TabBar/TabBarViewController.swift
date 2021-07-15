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
        configureTabBar()
    }
    
    private func configureTabBar() {
        view.backgroundColor = .white
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.7077005273, green: 0.7077005273, blue: 0.7077005273, alpha: 1)
        self.tabBar.tintColor = .black
        viewControllers = [
            configChildNavigationController(viewController: HomeViewController(), item: TabbarItem.home.item),
            configChildNavigationController(viewController: SearchViewController(), item: TabbarItem.search.item),
            configChildNavigationController(viewController: FavoritesViewController(), item: TabbarItem.favorites.item)
        ]
    }
    
    private func configChildNavigationController(viewController: UIViewController, item: UITabBarItem) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = item
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }

}
