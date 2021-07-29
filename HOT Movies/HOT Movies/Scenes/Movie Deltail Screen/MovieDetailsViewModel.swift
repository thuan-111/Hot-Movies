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
    let navigator: MovieDetailsNavigator
    let movie: Movie
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectedSimilarTrigger: Driver<Movie>
    }
    
    struct Output {
        let title: Driver<String>
        let details: Driver<[DetailsSectionModel]>
        let selectedSimilar: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let title = input.loadTrigger
            .map { self.movie.title }
        
        let details = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getMovieDetails(movieId: self.movie.id)
                    .asDriverOnErrorJustComplete()
            }
            .map { movieDetails -> [DetailsSectionModel] in
                return [.detail(items: [
                            .info(model: movieDetails),
                            .description(model: movieDetails.overview),
                            .castAndCrew(model: movieDetails.credits),
                            .similar(model: movieDetails.similar.results)
                    ])]
            }
        
        let selectedSimilar = input.selectedSimilarTrigger
            .do(onNext: navigator.pushToDetails(details:))
            .mapToVoid()
        
        return Output(title: title, details: details, selectedSimilar: selectedSimilar)
    }
}
