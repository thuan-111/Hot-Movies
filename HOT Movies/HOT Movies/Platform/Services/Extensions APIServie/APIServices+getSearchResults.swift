//
//  APIServices+getSearchResults.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 19/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension APIServices {
    func getSearchResult(queryString: String) -> Observable<[Movie]> {
        let queryStringFormatted = queryString.replacingOccurrences(of: " ", with: "-")
        let urlRequest = MovieURLs.shared.searchURL(query: queryStringFormatted)
        return APIServices.shared.request(URL: urlRequest,
                                          responseType: PageInfo.self)
            .map { (response) -> [Movie] in
                return response.results
            }
            .catchAndReturn([])
    }
}
