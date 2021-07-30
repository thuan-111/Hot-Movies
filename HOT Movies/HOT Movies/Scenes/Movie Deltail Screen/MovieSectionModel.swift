//
//  MovieSectionModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 21/07/2021.
//

import Foundation
import RxDataSources
import UIKit
import RxCocoa
import RxSwift

enum DetailsSectionModel {
    case detail(items: [SectionItems])
}

enum SectionItems {
    case info(model: MovieDetailsModel, likedStatus: Bool)
    case description(model: String)
    case castAndCrew(model: CreditModel)
    case similar(model: [Movie])
}

extension DetailsSectionModel: SectionModelType {
    
    typealias Item = SectionItems
    
    var items: [SectionItems] {
        switch self {
        case .detail(let items):
            return items.map { $0 }
        }
    }
    
    init(original: DetailsSectionModel, items: [Item]) {
        switch original {
        case .detail:
            self = .detail(items: items)
        }
    }
}
