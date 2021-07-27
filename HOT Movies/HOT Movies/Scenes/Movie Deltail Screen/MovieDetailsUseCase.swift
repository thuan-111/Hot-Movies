//
//  MovieDetailsUseCase.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import Foundation
import RxCocoa
import RxSwift

protocol MovieDetailsUseCaseType {
    
    func getMovieDetails(movieId: Int) -> Observable<MovieDetailsModel>
}

struct MovieDetailsUseCase: MovieDetailsUseCaseType {

    let movieRepository: MoviesRepositoryType
    
    func getMovieDetails(movieId: Int) -> Observable<MovieDetailsModel> {
        movieRepository.fetchMovieDetails(moiveId: movieId)
    }
}
