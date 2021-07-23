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
    
    func movieDetailsURL(movieId: Int) -> String {
        return baseURL + "/movie/\(movieId)?" + APIKey.key + "&language=\(Localize.currentLanguage())&append_to_response=videos,similar,credits"
    }
    
    func imageURL(imagePath: String) -> String {
        return "https://image.tmdb.org/t/p/w500/\(imagePath)"
    }
    
    func searchURL(query: String) -> String {
        return baseURL + "/search/movie?" + APIKey.key + "&query=\(query)" + "&language=\(Localize.currentLanguage())"
    }
    
    func youtubeTrailerPath(key: String) -> String {
        return "https://www.youtube.com/watch?v=\(key)"
    }
}
