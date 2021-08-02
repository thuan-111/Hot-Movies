//
//  FavoriteMovieEntity.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 28/07/2021.
//

import Foundation
import SQLite
import RxCocoa
import RxSwift
import Then

struct FavoriteMovieEntity {
    
    public static let shared = FavoriteMovieEntity()
    
    private let tableFavoriteMovies = Table("FavoriteMovies")
    
    private let id = Expression<Int>("id")
    private let title = Expression<String>("title")
    private let backdropPath = Expression<String>("backdropPath")
    private let posterPath = Expression<String>("posterPath")
    private let releaseDate = Expression<String>("releaseDate")
    private let voteAverage = Expression<Double>("voteAverage")
    
    private init() {
        do {
            if let connection = DatabaseManager.shared.connection {
                try connection
                    .run(tableFavoriteMovies
                            .create(temporary: false,
                                    ifNotExists: true,
                                    withoutRowid: false,
                                    block: {
                                        $0.column(id, primaryKey: true)
                                        $0.column(title)
                                        $0.column(backdropPath)
                                        $0.column(posterPath)
                                        $0.column(releaseDate)
                                        $0.column(voteAverage)
                                    }))
            } else {
                print("Can not create FavoriteMovie table: connection = Nil")
            }
        } catch {
            print("Can not create FavoriteMovie table: \(error)")
        }
    }
}

extension FavoriteMovieEntity {
    
    public func addNewFavoriteMovie(movie: Movie) -> Completable {
        
        return Completable.create { completable in
            guard let connection = DatabaseManager.shared.connection else {
                print("Add new movie failed, connetion = Nil")
                completable(.error(DatabaseErrors.connectionError))
                return Disposables.create()
            }
            
            do {
                let insert = tableFavoriteMovies.insert(id <- movie.id,
                                                        title <- movie.title,
                                                        backdropPath <- movie.backdropPath,
                                                        posterPath <- movie.posterPath,
                                                        releaseDate <- movie.releaseDate,
                                                        voteAverage <- movie.voteAverage)
                try connection.run(insert)
                print("Insert Successfully. Id = \(movie.id)")
                completable(.completed)
            } catch {
                print("Failed to insert new movie:\(error)")
                completable(.error(DatabaseErrors.addError))
            }
            return Disposables.create()
        }
    }
    
    public func addMovie(movie: Movie) -> Observable<Bool> {
        Observable.create { observable in
            guard let connection = DatabaseManager.shared.connection else {
                print("Add new movie failed, connetion = Nil")
                observable.onError(DatabaseErrors.connectionError)
                return Disposables.create()
            }
            
            do {
                let insert = tableFavoriteMovies.insert(id <- movie.id,
                                                        title <- movie.title,
                                                        backdropPath <- movie.backdropPath,
                                                        posterPath <- movie.posterPath,
                                                        releaseDate <- movie.releaseDate,
                                                        voteAverage <- movie.voteAverage)
                let insertCode = try connection.run(insert)
                print("Insert Successfully. Id = \(movie.id)")
                if insertCode != 0 {
                    observable.onNext(true)
                    observable.onCompleted()
                } else {
                    observable.onError(DatabaseErrors.addError)
                }
            } catch {
                print("Failed to insert new movie:\(error)")
                observable.onError(DatabaseErrors.addError)
            }
            return Disposables.create()
        }
    }
    
    public func fetchAllFavoriteMovie() -> Observable<[Movie]> {
        return Observable.create { observable in
            guard let connection = DatabaseManager.shared.connection else {
                print("Fetch all favorite movie failed, connetion = Nil")
                observable.onError(DatabaseErrors.connectionError)
                return Disposables.create()
            }
            do {
                let rows = try connection.prepare(tableFavoriteMovies)
                observable.onNext(rowsToMovies(rows: rows) ?? [])
            } catch {
                print("Failed to fetch all favorite movie:\(error)")
                observable.onError(DatabaseErrors.fetchError)
            }
            observable.onCompleted()
            return Disposables.create()
        }
    }
    
    public func deleteFavoriteMovieAt(movieId: Int) -> Observable<[Movie]> {
        
        return Observable.create { observable in
            guard let connection = DatabaseManager.shared.connection else {
                print("Delete favorite movie failed, connetion = Nil")
                observable.onError(DatabaseErrors.connectionError)
                return Disposables.create()
            }
            
            do {
                let row = tableFavoriteMovies.filter(id == movieId)
                try connection.run(row.delete())
                let rows = try connection.prepare(tableFavoriteMovies)
                observable.onNext(rowsToMovies(rows: rows) ?? [])
            } catch {
                print("Delete favorites movie failed: \(error)")
                observable.onError(DatabaseErrors.deleteError)
            }
            return Disposables.create()
        }
    }
    
    public func deleteMovie(movieId: Int) -> Observable<Bool> {
        return Observable.create { observable in
            guard let connection = DatabaseManager.shared.connection else {
                print("Delete favorite movie failed, connetion = Nil")
                observable.onError(DatabaseErrors.connectionError)
                return Disposables.create()
            }
            
            do {
                let row = tableFavoriteMovies.filter(id == movieId)
                let deleteCode = try connection.run(row.delete())
                if deleteCode != 0 {
                    print("Delete Successfully. Id = \(movieId)")
                    observable.onNext(false)
                    observable.onCompleted()
                } else {
                    observable.onError(DatabaseErrors.deleteError)
                }

            } catch {
                print("Delete favorites movie failed: \(error)")
                observable.onError(DatabaseErrors.deleteError)
            }
            return Disposables.create()
        }
    }
    
    public func checkForExistStatus(movieId: Int) -> Observable<Bool> {
        return Observable.create { observable in
            guard let connection = DatabaseManager.shared.connection else {
                print("Check favorite movie failed, connetion = Nil")
                observable.onError(DatabaseErrors.connectionError)
                return Disposables.create()
            }
            
            do {
                let rows = try connection.prepare(tableFavoriteMovies.filter(id == movieId))
                if movieId == rowsToMovies(rows: rows)?.first?.id {
                    observable.onNext(true)
                } else {
                    observable.onNext(false)
                }
                observable.onCompleted()
            } catch {
                print("Check favorite movie failed: \(error)")
                observable.onError(DatabaseErrors.checkExistError)
            }
            return Disposables.create()
        }

    }
    
    private func rowsToMovies(rows: AnySequence<Row>?) -> [Movie]? {
        
        let movies = rows?.map { row -> Movie in
            return Movie().with {
                            $0.id = row[id]
                            $0.title = row[title]
                            $0.backdropPath = row[backdropPath]
                            $0.posterPath = row[posterPath]
                            $0.releaseDate = row[releaseDate]
                            $0.voteAverage = row[voteAverage]
            }
        }
        return movies
    }
}
