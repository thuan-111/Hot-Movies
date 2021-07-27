//
//  MovieDetailsViewController.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources
import Reusable
import SafariServices

final class MovieDetailsViewController: UIViewController {
    
    @IBOutlet private weak var movieDetailsTableView: UITableView!
    
    typealias DataSource = RxTableViewSectionedReloadDataSource<DetailsSectionModel>
    
    var viewModel: MovieDetailsViewModel!

    private var similarMovie = PublishSubject<Movie>()
    private var dataSource: DataSource!
    
    let infoRowHeight: CGFloat = 350
    let similarRowHeight: CGFloat = 600
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configeTableView()
    }
    
    private func configeTableView() {
        movieDetailsTableView.separatorStyle = .none
        regiesterCell()
        setupDataSource()
    }
    
    private func regiesterCell() {
        movieDetailsTableView.do {
            $0.register(cellType: MovieInfosTableViewCell.self)
            $0.register(cellType: MovieDescriptionTableViewCell.self)
            $0.register(cellType: CreditTableViewCell.self)
            $0.register(cellType: SimilarMoviesTableViewCell.self)
            $0.rx.setDelegate(self)
                .disposed(by: rx.disposeBag)
        }
    }
    
    private func setupDataSource() {
        dataSource = DataSource(configureCell: configureCell)
    }
}

extension MovieDetailsViewController: Bindable {
    func bindViewModel() {
        
        let input = MovieDetailsViewModel.Input(loadTrigger: Driver.just(()),
                                                selectedSimilarTrigger: similarMovie
                                                    .asDriver(onErrorJustReturn: Movie()))
        
        let output = viewModel.transform(input)
        
        output.title
            .drive(self.rx.title)
            .disposed(by: rx.disposeBag)
        output.details
            .drive(movieDetailsTableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        output.selectedSimilar
            .drive()
            .disposed(by: rx.disposeBag)
        
    }
}

extension MovieDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .info:
            return infoRowHeight
        case .description:
            return UITableView.automaticDimension
        case .castAndCrew:
            return UITableView.automaticDimension
        case .similar:
            return similarRowHeight
        }
    }
}

extension MovieDetailsViewController {
    private var configureCell: DataSource.ConfigureCell {
        return { [weak self] (dataSource, tableView, indexPath, _) in
            switch dataSource[indexPath] {
            case .info(let model):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: MovieInfosTableViewCell.self)
                cell.configureCell(movie: model)
                return cell
            case .description(let model):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: MovieDescriptionTableViewCell.self)
                cell.showMoreButtonTapped = { self?.movieDetailsTableView.reloadData() }
                cell.configureCell(description: model)
                return cell
            case .castAndCrew(let model):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: CreditTableViewCell.self)
                cell.configureCell(credits: model)
                return cell
            case .similar(let model):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: SimilarMoviesTableViewCell.self)
                cell.similarMovieTapped = { self?.similarMovie.onNext($0) }
                cell.configureCell(movies: model)
                return cell
            }
        }
    }
}
