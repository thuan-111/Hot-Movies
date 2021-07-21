//
//  SharedSequenceConvertibleType.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension SharedSequenceConvertibleType {
    
    public func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}
