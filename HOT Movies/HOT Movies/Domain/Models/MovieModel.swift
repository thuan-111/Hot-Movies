//
//  MovieModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import Foundation
import ObjectMapper
import Then

struct Movie {
    var idMovie: Int
    var title: String
    var backdropPath: String
    var posterPath: String
    var overview: String
    var releaseDate: String
    var voteAverage: Float
    var voteCount: Int
}

extension Movie {
    init() {
        self.init(
            idMovie: 0,
            title: "",
            backdropPath: "",
            posterPath: "",
            overview: "",
            releaseDate: "",
            voteAverage: 0.0,
            voteCount: 0
        )
    }
}

extension Movie: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        idMovie <- map["id"]
        title <- map["title"]
        backdropPath <- map["backdrop_path"]
        posterPath <- map["poster_path"]
        overview <- map["overview"]
        releaseDate <- map["release_date"]
        voteAverage <- map["vote_average"]
        voteCount <- map["vote_count"]
    }
}
