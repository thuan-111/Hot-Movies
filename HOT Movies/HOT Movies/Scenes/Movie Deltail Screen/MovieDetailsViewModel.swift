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
        let likeTrigger: Driver<Bool>
        let playTrigger: Driver<String?>
    }
    
    struct Output {
        let title: Driver<String>
        let detailsAndLiked: Driver<[DetailsSectionModel]>
        let selectedSimilar: Driver<Void>
        let voidDrivers: [Driver<Void>]
    }
    
    func transform(_ input: Input) -> Output {
        
        let likedStatus = BehaviorRelay<Bool>(value: false)
        
        let title = input.loadTrigger
            .map { movie.title }
        
        let checkLiked = input.loadTrigger
            .flatMapLatest { _ in
                return useCase.checkLikedStatus(moiveId: movie.id)
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: likedStatus.accept(_:))
            .mapToVoid()

        let liked = input.likeTrigger
            .flatMapLatest { isLiked -> Driver<Bool> in
                if isLiked {
                    return useCase.deleteMovie(movieId: movie.id)
                        .asDriverOnErrorJustComplete()
                } else {
                    return useCase.addMovie(movie: movie)
                        .asDriverOnErrorJustComplete()
                }
            }
            .do(onNext: likedStatus.accept(_:))
            .mapToVoid()
        
        let details = input.loadTrigger
            .flatMapLatest { _ in
                return useCase.getMovieDetails(movieId: movie.id)
                    .asDriverOnErrorJustComplete()
            }

        let detailsAndLiked = Driver.combineLatest(details, likedStatus.asDriver())
            .map { movieDetails, isLiked -> [DetailsSectionModel] in
                return [.detail(items: [
                    .info(model: movieDetails,
                          likedStatus: isLiked),
                    .description(model: movieDetails.overview),
                    .castAndCrew(model: movieDetails.credits),
                    .similar(model: movieDetails.similar.results)
                ])]
            }
            .asDriver(onErrorJustReturn: [DetailsSectionModel]())
        
        let selectedSimilar = input.selectedSimilarTrigger
            .do(onNext: navigator.pushToDetails(details:))
            .mapToVoid()
        
        let playTrailer = input.playTrigger
            .do(onNext: navigator.pushYoutube(key:))
            .mapToVoid()

        let voidDrivers = [liked, checkLiked, playTrailer]

        return Output(title: title,
                      detailsAndLiked: detailsAndLiked,
                      selectedSimilar: selectedSimilar,
                      voidDrivers: voidDrivers)
    }
}
