//
//  SearchNavigator.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 19/07/2021.
//

import Foundation
import UIKit

protocol SearchNavigatorType {
    func pushToDetails(details: Movie)
}

struct SearchNavigator: SearchNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    func pushToDetails(details: Movie) {
        let viewController = MovieDetailsViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
