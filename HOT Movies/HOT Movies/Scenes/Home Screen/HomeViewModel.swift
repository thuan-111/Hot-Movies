//
//  HomeViewModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

struct HomeViewModel {
    
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
    let dataSource = BehaviorRelay<[Movie]>(value: [Movie]())
}

extension HomeViewModel: ViewModel {
    
    struct Input {
        let loadTrigger: Driver<Int>
        let selectTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let currentMovies: Driver<[Movie]>
        let movies: Driver<[Movie]>
        let selected: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let currentMovies = input.loadTrigger
            .withLatestFrom(input.loadTrigger)
            .flatMapLatest { pageNumber in
                return self.useCase.getMovies(page: pageNumber)
                    .asDriverOnErrorJustComplete()
            }
            .do { movies in
                dataSource.accept(dataSource.value + movies)
            }
        
        let selected = input.selectTrigger
            .withLatestFrom(dataSource.asDriver()) { indexPath, movies in
                return movies[indexPath.row]
            }
            .do(onNext: navigator.pushToDetails(details:))
            .mapToVoid()
        
        return Output(currentMovies: currentMovies, movies: dataSource.asDriver(), selected: selected)
    }
}
