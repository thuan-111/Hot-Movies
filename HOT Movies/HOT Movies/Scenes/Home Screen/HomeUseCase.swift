//
//  HomeUseCase.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeUseCaseType {
    func getMovies(page: Int) -> Observable<[Movie]>
}

struct HomeUseCase: HomeUseCaseType {
    func getMovies(page: Int) -> Observable<[Movie]> {
        return APIServices.shared.getMovies(page: page)
    }
}
