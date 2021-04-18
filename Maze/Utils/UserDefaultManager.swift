//
//  UserDefaultManager.swift
//  Maze
//
//  Created by Ismail on 18/04/2021.
//

import Foundation

class UserDefaultManager {
    
    static var shared = UserDefaultManager()
    private let userDefault = UserDefaults.standard
    private init() {
        
    }
    
    struct Keys {
        static let pageNumber: String = "pageNumber"
    }
    
    func saveCurrentPage(_ page: Int) {
        userDefault.set(page, forKey: Keys.pageNumber)
    }
    
    func getPageNumber() -> Int {
        return userDefault.integer(forKey: Keys.pageNumber)
    }
   
}
