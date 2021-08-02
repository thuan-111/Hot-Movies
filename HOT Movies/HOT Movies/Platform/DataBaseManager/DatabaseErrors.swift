//
//  DatabaseErrors.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 29/07/2021.
//

import Foundation

enum DatabaseErrors: Error {
    case connectionError
    case fetchError
    case addError
    case deleteError
    case checkExistError
}
