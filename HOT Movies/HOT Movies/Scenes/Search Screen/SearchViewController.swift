//
//  SearchViewController.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 14/07/2021.
//

import UIKit
import RxCocoa
import RxSwift
import Then
import NSObject_Rx

final class SearchViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var moviesTableView: UITableView!
    
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        hideKeyboardWhenTappedAround()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        title = L10n.searchTitle.localized()
        searchBar.placeholder = L10n.searchPlaceholder.localized()
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

extension SearchViewController: Bindable {
    func bindViewModel() {
        let input = SearchViewModel.Input(
            searchBarInput: searchBar.rx.text.orEmpty.asDriver(),
            selectTrigger: moviesTableView.rx.itemSelected.asDriver()
        )
        let output = viewModel.transform(input)
        
        output.movies
            .drive(moviesTableView.rx.items) { moviesTableView, index, movie in
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

extension SearchViewController {
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
