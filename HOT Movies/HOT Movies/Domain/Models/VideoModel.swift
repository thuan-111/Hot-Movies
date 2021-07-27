//
//  VideoModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 26/07/2021.
//

import Foundation
import ObjectMapper

struct VideoModel {
    var key: String
    var name: String
}

extension VideoModel {
    init() {
        self.init(
            key: "",
            name: ""
        )
    }
}

extension VideoModel: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        key <- map["key"]
        name <- map["name"]
    }
}
