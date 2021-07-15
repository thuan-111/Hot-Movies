//
//  MovieURLs.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import Foundation
import Localize_Swift

struct MovieURLs {
    
    public static let shared = MovieURLs()
    
    var baseURL: String
    
    init() {
        baseURL = "https://api.themoviedb.org/3"
    }
    
    func allMovieURL(page: Int) -> String {
        let path = "/discover/movie?sort_by=popularity.desc&"
        return baseURL + path + APIKey.key + "&language=\(Localize.currentLanguage())" + "&page=\(page)"
    }
    
    func movieDetailURL(idMovie: Int) -> String {
        return baseURL + "/movie/\(idMovie)?" + APIKey.key + "&language=\(Localize.currentLanguage())"
    }
    
    func imageURL(imagePath: String) -> String {
        return "https://image.tmdb.org/t/p/w500/\(imagePath)"
    }
    
    func searchURL(query: String) -> String {
        return baseURL + "/search/movie?" + APIKey.key + "&query=\(query)" + "&language=\(Localize.currentLanguage())"
    }
}
