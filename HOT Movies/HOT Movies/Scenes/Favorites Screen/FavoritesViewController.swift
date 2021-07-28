//
//  FavoritesViewController.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 14/07/2021.
//

import UIKit

final class FavoritesViewController: UIViewController {

    @IBOutlet private weak var moviesTableView: UITableView!
    
    var viewModel: FavoritesViewModel!
    
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
        title = L10n.favoritesTitle.localized()
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configureTableView() {
        moviesTableView.do {
            $0.register(cellType: movieTableViewCell.self)
            $0.rowHeight = 200
            $0.separatorStyle = .none
            $0.selectionFollowsFocus = false
        }
    }
}

extension FavoritesViewController: Bindable {
    
    func bindViewModel() {
        
    }
}
