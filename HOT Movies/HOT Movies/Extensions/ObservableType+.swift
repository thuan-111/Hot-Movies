//
//  ObservableType+.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 16/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    public func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
}
