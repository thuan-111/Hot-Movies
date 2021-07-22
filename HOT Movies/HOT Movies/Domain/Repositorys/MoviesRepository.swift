//
//  MoviesRepository.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 22/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol MoviesRepositoryType {
    
    func fetchRemoteMovies(page: Int) -> Observable<[Movie]>
    
    func fetchSearchMoviesResult(queryString: String) -> Observable<[Movie]>
}

struct MoviesRepository: MoviesRepositoryType {
    
    func fetchRemoteMovies(page: Int) -> Observable<[Movie]> {
        return APIServices.shared.getMovies(page: page)
    }
    
    func fetchSearchMoviesResult(queryString: String) -> Observable<[Movie]> {
        return APIServices.shared.getSearchResult(queryString: queryString)
    }
}
