//
//  FavoritesViewModel.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 28/07/2021.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

struct FavoritesViewModel {
    
    let navigator: FavoritesNavigatorType
    let useCase: FavoritesUseCase
    let dataSource = BehaviorRelay<[Movie]>(value: [Movie]())
}

extension FavoritesViewModel: ViewModel {
    
    struct Input {
        let loadTrigger: Driver<Int>
        let selectTrigger: Driver<IndexPath>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input) -> Output {
        return Output()
    }
}
