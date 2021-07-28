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
    
    func deleteFavoriteMovieAt(movieId: Int) -> Completable
}

struct FavoritesRepository: FavoritesRepositoryType {
    
    func addNewFavoriteMovie(movie: Movie) -> Completable {
        return FavoriteMovieEntity.shared.addNewFavoriteMovie(movie: movie)
    }
    
    func fetchAllFavoriteMovie() -> Observable<[Movie]> {
        return FavoriteMovieEntity.shared.fetchAllFavoriteMovie()
    }
    
    func deleteFavoriteMovieAt(movieId: Int) -> Completable {
       return FavoriteMovieEntity.shared.deleteFavoriteMovieAt(movieId: movieId)
    }
}
