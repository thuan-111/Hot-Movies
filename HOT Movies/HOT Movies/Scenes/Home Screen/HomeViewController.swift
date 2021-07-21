//
//  HomeViewController.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 14/07/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Localize_Swift
import Then
import Reusable
import NSObject_Rx

final class HomeViewController: UIViewController {

    @IBOutlet private weak var moviesTableView: UITableView!
    
    var currentPageNumber = 1
    var pageLoading = BehaviorSubject<Int>(value: 1)
    var viewModel: HomeViewModel!
    
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
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configureTableView() {
        moviesTableView.do {
            $0.register(cellType: movieTableViewCell.self)
            $0.delegate = self
            $0.rowHeight = 200
            $0.separatorStyle = .none
            $0.selectionFollowsFocus = false
        }
    }
}

extension HomeViewController: Bindable {
    func bindViewModel() {
        let input = HomeViewModel.Input(loadTrigger: pageLoading.asDriver(onErrorJustReturn: 1),
                                        selectTrigger: moviesTableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
        
        output.currentMovies
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.movies.drive(moviesTableView.rx.items) { moviesTableView, index, movie in
            let indexPath = IndexPath(item: index, section: 0)
            let cell: movieTableViewCell = moviesTableView.dequeueReusableCell(for: indexPath)
            cell.configureCell(movie: movie)
            return cell
        }
        .disposed(by: rx.disposeBag)
        
        output.selected
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension HomeViewController: UIScrollViewDelegate, UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = moviesTableView.contentOffset.y
        let positionLoadMoreData = moviesTableView.contentSize.height - 100 - scrollView.frame.size.height
        if position > positionLoadMoreData {
            currentPageNumber += 1
            pageLoading.onNext(currentPageNumber)
        }
    }
}
