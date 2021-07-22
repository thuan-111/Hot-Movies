//
//  SearchViewModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 19/07/2021.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

struct SearchViewModel {
    let navigator: SearchNavigatorType
    let useCase: SearchUseCaseType
}

extension SearchViewModel: ViewModel {
    struct Input {
        let searchBarInput: Driver<String>
        let selectTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let movies: Driver<[Movie]>
        let selected: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let movies = input.searchBarInput
            .debounce(.milliseconds(300))
            .filter { !$0.isEmpty }
            .flatMapLatest { query in
                return self.useCase.getMoviesSearching(queryString: query)
                    .asDriverOnErrorJustComplete()
            }
        
        let selected = input.selectTrigger
            .withLatestFrom(movies) { indexPath, movies in
                return movies[indexPath.row]
            }
            .do(onNext: navigator.pushToDetails(details:))
            .mapToVoid()
        
        return Output(movies: movies, selected: selected)
    }
}
