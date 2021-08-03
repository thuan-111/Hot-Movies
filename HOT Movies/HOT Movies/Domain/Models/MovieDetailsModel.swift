//
//  MovieDetailsModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import Foundation
import RxCocoa
import RxSwift
import ObjectMapper

struct MovieDetailsModel {
    var id: Int
    var title: String
    var posterPath: String
    var backdropPath: String
    var overview: String
    var releaseDate: String
    var voteAverage: Float
    var credits: CreditModel
    var similar: PageInfo
    var videos: VideosModel
    var runtime: Int
}

extension MovieDetailsModel {
    init() {
        self.init(
            id: 0,
            title: "",
            posterPath: "",
            backdropPath: "",
            overview: "",
            releaseDate: "",
            voteAverage: 0,
            credits: CreditModel(),
            similar: PageInfo(),
            videos: VideosModel(),
            runtime: 0
        )
    }
}

extension MovieDetailsModel: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        backdropPath <- map["backdrop_path"]
        posterPath <- map["poster_path"]
        overview <- map["overview"]
        releaseDate <- map["release_date"]
        voteAverage <- map["vote_average"]
        credits <- map["credits"]
        similar <- map ["similar"]
        videos <- map ["videos"]
        runtime <- map["runtime"]
    }
}
