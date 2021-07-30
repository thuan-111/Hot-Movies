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
    
    private let movieWillRemove = PublishSubject<Movie>()
    private let loadDataTrigger = PublishSubject<Void>()
    
    var viewModel: FavoritesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBar()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDataTrigger.onNext(())
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
            $0.register(cellType: FavoritesTableViewCell.self)
            $0.rowHeight = 200
            $0.separatorStyle = .none
            $0.selectionFollowsFocus = false
        }
    }
}

extension FavoritesViewController: Bindable {
    
    func bindViewModel() {
        let input = FavoritesViewModel.Input(loadTrigger: loadDataTrigger
                                                .asDriver(onErrorJustReturn: ()),
                                             selectTrigger: moviesTableView.rx.itemSelected
                                                .asDriver(),
                                             deleteTrigger: movieWillRemove
                                                .asDriver(onErrorJustReturn: Movie()))
        let output = viewModel.transform(input)
        
        output.loadData
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.movie
            .drive(moviesTableView.rx.items) { [weak self] (moviesTableView, index, movie) in
                let indexPath = IndexPath(index: index)
                let cell = moviesTableView.dequeueReusableCell(for: indexPath,
                                                               cellType: FavoritesTableViewCell.self)
                cell.removeButtonTapped = { self?.movieWillRemove.onNext($0) }
                cell.configureCell(movie: movie)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.selected
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.deleted
            .drive()
            .disposed(by: rx.disposeBag)
    }
}
