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
        navigationController.pushViewController(viewController, animated: true)
    }
}
