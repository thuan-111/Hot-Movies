//
//  VideosModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 26/07/2021.
//

import Foundation
import ObjectMapper

struct VideosModel {
    var results: [VideoModel]
}

extension VideosModel {
    init() {
        self.init(
            results: [VideoModel]()
        )
    }
}

extension VideosModel: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        results <- map["results"]
    }
}
