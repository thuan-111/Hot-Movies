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
    
    func addNewFavoriteMovie(movie: Movie)
    
    func fetchAllFavoriteMovie() -> Observable<[Movie]>
    
    func deleteFavoriteMovieAt(movieId: Int)
}

struct FavoritesRepository: FavoritesRepositoryType {
    
    func addNewFavoriteMovie(movie: Movie) {
        FavoriteMovieEntity.shared.addNewFavoriteMovie(movie: movie)
    }
    
    func fetchAllFavoriteMovie() -> Observable<[Movie]> {
        return Observable.create { observable in
            let data = FavoriteMovieEntity.shared.fetchAllFavoriteMovie()
            observable.onNext(data)
            return Disposables.create()
        }
    }
    
    func deleteFavoriteMovieAt(movieId: Int) {
        FavoriteMovieEntity.shared.deleteFavoriteMovieAt(movieId: movieId)
    }
}
