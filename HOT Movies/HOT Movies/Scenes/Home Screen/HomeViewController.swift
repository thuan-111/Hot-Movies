//
//  HomeViewController.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 14/07/2021.
//

import UIKit
import RxSwift
import Localize_Swift
import Then
import Reusable

final class HomeViewController: UIViewController {

    @IBOutlet private weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBar()
        configureTableView()
    }
    
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureNavigationBar() {
        title = L10n.hotMoviesTitle.localized()
    }
    
    private func configureTableView() {
        moviesTableView.do {
            $0.register(cellType: movieTableViewCell.self)
            $0.rowHeight = 200
            $0.separatorStyle = .none
            $0.tableHeaderView = .none
        }
    }
}
