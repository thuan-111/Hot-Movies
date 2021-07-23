//
//  MovieDetailsViewModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

struct MovieDetailsViewModel {
    
    let useCase: MovieDetailsUseCaseType
    let movie: Movie
    
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let title: Driver<String>
        let details: Driver<[DetailsSectionModel]>
    }
    
    func transform(_ input: Input) -> Output {
        
        let title = input.loadTrigger
            .map { self.movie.title }
        
        let details = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getMovieDetails(movieId: self.movie.idMovie)
                    .asDriverOnErrorJustComplete()
            }
            .map {
                [.detail(items: [
                        .info(model: $0),
                        .description(model: self.movie.overview),
                        .castAndCrew(model: $0.credits),
                        .similar(model: $0.similar.results)
                ])]
            }
        
        return Output(title: title, details: details)
    }
}
