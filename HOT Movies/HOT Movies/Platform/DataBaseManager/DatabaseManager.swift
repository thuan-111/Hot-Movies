//
//  DatabaseManager.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 28/07/2021.
//

import Foundation
import SQLite

struct DatabaseManager {
    
    public static let shared = DatabaseManager()
    
    public let connection: Connection?
    
    private let databaseFileName = "hotMovies.sqlite3"
    
    private init() {
        
        if let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                        .first as String? {
            do {
                connection = try Connection("\(path)/\(databaseFileName)")
            } catch {
                connection = nil
                print("Cannot connect database: \(error)")
            }
        } else {
            connection = nil
            print("Cannot connect database: databasePath = Nil")
        }
    }
    
}
