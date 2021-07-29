//
//  FavoritesViewModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 28/07/2021.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

struct FavoritesViewModel {
    
    let navigator: FavoritesNavigatorType
    let useCase: FavoritesUseCase
    let dataSource = BehaviorRelay<[Movie]>(value: [Movie]())
}

extension FavoritesViewModel: ViewModel {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
        let deleteTrigger: Driver<Movie>
    }
    
    struct Output {
        let loadData: Driver<Void>
        let movie: Driver<[Movie]>
        let selected: Driver<Void>
        let deleted: Driver<[Movie]>
    }
    
    func transform(_ input: Input) -> Output {
        
        let loadData = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getFavoriteMovies()
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: dataSource.accept(_:))
            .mapToVoid()
        
        let selected = input.selectTrigger
            .withLatestFrom(dataSource.asDriver()) { indexPath, movies in
                return movies[indexPath.row]
            }
            .do(onNext: navigator.pushToDetails(details:))
            .mapToVoid()
        
        let deleted = input.deleteTrigger
            .debounce(.milliseconds(300))
            .flatMapLatest { movie in
                return self.useCase.deleteFavoriteMovieAt(movieId: movie.id)
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: dataSource.accept)

        return Output(loadData: loadData,
                      movie: dataSource.asDriver(),
                      selected: selected,
                      deleted: deleted)
    }
}
