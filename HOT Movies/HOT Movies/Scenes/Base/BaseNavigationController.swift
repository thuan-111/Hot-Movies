//
//  BaseNavigationController.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 16/07/2021.
//

import Foundation
import UIKit

final class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    func configureViews() {
        
        delegate = self
        
        navigationBar.do {
            $0.isTranslucent = false
            $0.backgroundColor = .white
        }
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    
}
