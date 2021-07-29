//
//  FavoritesUseCase.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 28/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol FavoritesUseCaseType {
    
    func getFavoriteMovies() -> Observable<[Movie]>
    
    func deleteFavoriteMovieAt(movieId: Int) -> Observable<[Movie]>
}

struct FavoritesUseCase: FavoritesUseCaseType {
    
    let favoritesRepository: FavoritesRepositoryType
    
    func getFavoriteMovies() -> Observable<[Movie]> {
        return favoritesRepository.fetchAllFavoriteMovie()
    }
    
    func deleteFavoriteMovieAt(movieId: Int) -> Observable<[Movie]> {
        return favoritesRepository.deleteFavoriteMovieAt(movieId: movieId)
    }
}
