//
//  APIServies+getMovieDetails.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 26/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension APIServices {
    func getMovieDetails(moiveId: Int) -> Observable<MovieDetailsModel> {
        let urlRequest = MovieURLs.shared.movieDetailsURL(movieId: moiveId)
        return APIServices.shared.request(URL: urlRequest, responseType: MovieDetailsModel.self)
    }
}
