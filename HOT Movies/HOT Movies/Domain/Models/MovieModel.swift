//
//  MovieModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import Foundation
import ObjectMapper
import Then

struct Movie: Then {
    var id: Int
    var title: String
    var backdropPath: String
    var posterPath: String
    var releaseDate: String
    var voteAverage: Double
}

extension Movie {
    init() {
        self.init(
            id: 0,
            title: "",
            backdropPath: "",
            posterPath: "",
            releaseDate: "",
            voteAverage: 0.0
        )
    }
}

extension Movie: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        backdropPath <- map["backdrop_path"]
        posterPath <- map["poster_path"]
        releaseDate <- map["release_date"]
        voteAverage <- map["vote_average"]
    }
}
