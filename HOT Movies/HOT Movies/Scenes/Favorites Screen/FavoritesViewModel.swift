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
    }
    
    struct Output {
        let movie: Driver<[Movie]>
        let selected: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let movie = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getFavoriteMovies()
                    .asDriverOnErrorJustComplete()
            }
        
        let selected = input.selectTrigger
            .withLatestFrom(movie) { indexPath, movies in
                return movies[indexPath.row]
            }
            .do(onNext: navigator.pushToDetails(details:))
            .mapToVoid()
        
        return Output(movie: movie, selected: selected)
    }
}
