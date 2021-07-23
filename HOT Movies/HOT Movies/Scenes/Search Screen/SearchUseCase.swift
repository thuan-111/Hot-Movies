//
//  SearchUseCase.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 19/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchUseCaseType {
    func getMoviesSearching(queryString: String) -> Observable<[Movie]>
}

struct SearchUseCase: SearchUseCaseType {
    
    let moviesRepository: MoviesRepositoryType
    
    func getMoviesSearching(queryString: String) -> Observable<[Movie]> {
        return moviesRepository.fetchSearchMoviesResult(queryString: queryString)
    }
}
