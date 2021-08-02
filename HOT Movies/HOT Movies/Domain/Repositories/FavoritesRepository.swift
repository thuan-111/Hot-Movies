//
//  FavoritesRepository.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 28/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol FavoritesRepositoryType {
    
    func addNewFavoriteMovie(movie: Movie) -> Completable
    
    func fetchAllFavoriteMovie() -> Observable<[Movie]>
    
    func deleteFavoriteMovieAt(movieId: Int) -> Observable<[Movie]>
    
    func checkForExistence(movieId: Int) -> Observable<Bool>
    
    func addMovie(movie: Movie) -> Observable<Bool>
    
    func deleteMovie(movieId: Int) -> Observable<Bool>
}

struct FavoritesRepository: FavoritesRepositoryType {
    
    func addNewFavoriteMovie(movie: Movie) -> Completable {
        return FavoriteMovieEntity.shared.addNewFavoriteMovie(movie: movie)
    }
    
    func fetchAllFavoriteMovie() -> Observable<[Movie]> {
        return FavoriteMovieEntity.shared.fetchAllFavoriteMovie()
    }
    
    func deleteFavoriteMovieAt(movieId: Int) -> Observable<[Movie]> {
        return FavoriteMovieEntity.shared.deleteFavoriteMovieAt(movieId: movieId)
    }
    
    func checkForExistence(movieId: Int) -> Observable<Bool> {
        return FavoriteMovieEntity.shared.checkForExistStatus(movieId: movieId)
    }
    
    func addMovie(movie: Movie) -> Observable<Bool> {
        return FavoriteMovieEntity.shared.addMovie(movie: movie)
    }
    
    func deleteMovie(movieId: Int) -> Observable<Bool> {
        return FavoriteMovieEntity.shared.deleteMovie(movieId: movieId)
    }
}
