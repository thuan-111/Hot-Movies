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

    private let similarMovie = PublishSubject<Movie>()
    private let likeButtonTrigger = PublishSubject<Bool>()
    private let loadTrigger = BehaviorSubject<Void>(value: ())
    private let playTrigger = PublishSubject<String?>()
    
    private var dataSource: DataSource!
    
    let infoRowHeight: CGFloat = 350
    let similarRowHeight: CGFloat = 600
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configeTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTrigger.onNext(())
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
        
        let input = MovieDetailsViewModel.Input(loadTrigger: loadTrigger
                                                    .asDriver(onErrorJustReturn: ()),
                                                selectedSimilarTrigger: similarMovie
                                                    .asDriver(onErrorJustReturn: Movie()),
                                                likeTrigger: likeButtonTrigger
                                                    .asDriver(onErrorJustReturn: false),
                                                playTrigger: playTrigger
                                                    .asDriver(onErrorJustReturn: nil))
        let output = viewModel.transform(input)
        
        output.title
            .drive(self.rx.title)
            .disposed(by: rx.disposeBag)
        
        output.detailsAndLiked
            .drive(movieDetailsTableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        output.selectedSimilar
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.voidDrivers.forEach {
            $0.drive()
                .disposed(by: rx.disposeBag)
        }
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
            case .info(let model, let likedStatus):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: MovieInfosTableViewCell.self)
                cell.likeButtonTapped = { self?.likeButtonTrigger.onNext($0) }
                cell.playButtonTapped = { self?.playTrigger.onNext($0) }
                cell.configureCell(movie: model, likedStatus: likedStatus)
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
