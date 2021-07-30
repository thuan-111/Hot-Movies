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
    
    func checkLikedStatus(moiveId: Int) -> Observable<Bool>
    
    func addMovie(movie: Movie) -> Observable<Bool>
    
    func deleteMovie(movieId: Int) -> Observable<Bool>
}

struct MovieDetailsUseCase: MovieDetailsUseCaseType {

    let movieRepository: MoviesRepositoryType
    
    let favoritesRepository: FavoritesRepositoryType
    
    func getMovieDetails(movieId: Int) -> Observable<MovieDetailsModel> {
        movieRepository.fetchMovieDetails(moiveId: movieId)
    }
    
    func checkLikedStatus(moiveId: Int) -> Observable<Bool> {
        favoritesRepository.checkForExistence(movieId: moiveId)
    }
    
    func addMovie(movie: Movie) -> Observable<Bool> {
        favoritesRepository.addMovie(movie: movie)
    }
    
    func deleteMovie(movieId: Int) -> Observable<Bool> {
        favoritesRepository.deleteMovie(movieId: movieId)
    }
}
