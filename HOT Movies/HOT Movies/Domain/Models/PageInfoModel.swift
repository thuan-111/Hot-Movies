//
//  PageInfoModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 19/07/2021.
//

import Foundation
import ObjectMapper
import Then

struct PageInfo {
    var page: Int
    var results: [Movie]
}

extension PageInfo {
    init() {
        self.init(
            page: 0,
            results: [Movie]()
        )
    }
}

extension PageInfo: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        page <- map["page"]
        results <- map["results"]
    }
}
