//
//  HomeViewController.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 14/07/2021.
//

import UIKit
import RxSwift
import Localize_Swift

final class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(MovieURLs.shared.allMovieURL(page: 1))
    }
}
