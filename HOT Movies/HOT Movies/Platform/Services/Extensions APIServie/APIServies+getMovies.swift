//
//  APIServies+getAllMovie.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension APIServices {
    func getMovies(page: Int) -> Observable<[Movie]> {
        let urlRequest = MovieURLs.shared.allMovieURL(page: page)
        return request(URL: urlRequest, responseType: PageInfo.self)
            .map { (response) -> [Movie] in
                let movie = response.results
                return movie
            }
            .catchAndReturn([])
    }
    
    func getPageInfo(page: Int) -> Observable<Int> {
        let urlRequest = MovieURLs.shared.allMovieURL(page: page)
        return request(URL: urlRequest, responseType: PageInfo.self)
            .map { (response) -> Int in
                return response.page
            }
    }
    
}
