//
//  FavoritesViewController.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 14/07/2021.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

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
        let input = FavoritesViewModel.Input(loadTrigger: Driver.just(()),
                                             selectTrigger: moviesTableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
        
        output.movie
            .drive(moviesTableView.rx.items) { moviesTableView, index, movie in
                let indexPath = IndexPath(index: index)
                let cell = moviesTableView.dequeueReusableCell(for: indexPath,
                                                               cellType: movieTableViewCell.self)
                cell.configureCell(movie: movie)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.selected
            .drive()
            .disposed(by: rx.disposeBag)
    }
}
