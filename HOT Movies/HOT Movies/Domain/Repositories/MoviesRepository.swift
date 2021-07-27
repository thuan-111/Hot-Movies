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
    
    func fetchMovieDetails(moiveId: Int) -> Observable<MovieDetailsModel>
}

struct MoviesRepository: MoviesRepositoryType {
    
    func fetchRemoteMovies(page: Int) -> Observable<[Movie]> {
        return APIServices.shared.getMovies(page: page)
    }
    
    func fetchSearchMoviesResult(queryString: String) -> Observable<[Movie]> {
        return APIServices.shared.getSearchResult(queryString: queryString)
    }
    
    func fetchMovieDetails(moiveId: Int) -> Observable<MovieDetailsModel> {
        return APIServices.shared.getMovieDetails(moiveId: moiveId)
    }
}
