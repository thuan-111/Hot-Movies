//
//  CastAndCrewModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 23/07/2021.
//

import Foundation
import ObjectMapper
import Then

struct CastAndCrewModel {
    var id: Int
    var name: String
    var profilePath: String
}

extension CastAndCrewModel {
    init() {
        self.init(
            id: 0,
            name: "",
            profilePath: ""
        )
    }
}

extension CastAndCrewModel: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        profilePath <- map["profile_path"]
    }
}
