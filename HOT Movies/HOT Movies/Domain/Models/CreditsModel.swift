//
//  CreditsModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 23/07/2021.
//

import Foundation
import ObjectMapper
import Then

struct CreditModel {
    var id: Int
    var cast: [CastAndCrewModel]
    var crew: [CastAndCrewModel]
}

extension CreditModel {
    init() {
        self.init(
            id: 0,
            cast: [CastAndCrewModel](),
            crew: [CastAndCrewModel]()
        )
    }
}

extension CreditModel: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        cast <- map["cast"]
        crew <- map["crew"]
    }
}
