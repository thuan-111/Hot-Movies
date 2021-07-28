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
                                    block: { (table) in
                                        table.column(self.id, primaryKey: true)
                                        table.column(self.title)
                                        table.column(self.backdropPath)
                                        table.column(self.posterPath)
                                        table.column(self.releaseDate)
                                        table.column(self.voteAverage)
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
    
    public func addNewFavoriteMovie(movie: Movie) {
        guard let connection = DatabaseManager.shared.connection else {
            print("Add new movie failed, connetion = Nil")
            return
        }
        do {
            let insert = tableFavoriteMovies.insert(id <- movie.movieId,
                                                    title <- movie.title,
                                                    backdropPath <- movie.backdropPath,
                                                    posterPath <- movie.posterPath,
                                                    releaseDate <- movie.releaseDate,
                                                    voteAverage <- movie.voteAverage)
            try connection.run(insert)
            print("Insert Successfully. Id = \(movie.movieId)")
        } catch {
            print("Failed to insert new movie:\(error)")
        }
    }
    
    public func fetchAllFavoriteMovie() -> [Movie] {
        guard let connection = DatabaseManager.shared.connection else {
            print("Fetch all favorite movie failed, connetion = Nil")
            return []
        }
        do {
            let rows = try connection.prepare(tableFavoriteMovies)
            return rowsToMovies(rows: rows) ?? []
        } catch {
            print("Failed to fetch all favorite movie:\(error)")
            return []
        }
    }
    
    public func deleteFavoriteMovieAt(movieId: Int) {
        guard let connection = DatabaseManager.shared.connection else {
            print("Delete favorite movie failed, connetion = Nil")
            return
        }
        do {
            let row = tableFavoriteMovies.filter(id == movieId)
            try connection.run(row.delete())
        } catch {
            print("Delete favorites movie failed: \(error)")
            return
        }
        
    }
    
    private func rowsToMovies(rows: AnySequence<Row>?) -> [Movie]? {
        
        let movies = rows?.map({ row -> Movie in
            var movie = Movie()
            movie.movieId = row[id]
            movie.title = row[title]
            movie.backdropPath = row[backdropPath]
            movie.posterPath = row[posterPath]
            movie.releaseDate = row[releaseDate]
            movie.voteAverage = row[voteAverage]
            return movie
        })
        
        return movies
    }
    
}
