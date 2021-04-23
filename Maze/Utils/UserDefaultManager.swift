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
        static let user: String = "user"
        static let subject: String = "subject"
    }
    
    func saveCurrentPage(_ page: Int) {
        userDefault.set(page, forKey: Keys.pageNumber)
    }
    
    func getPageNumber() -> Int {
        return userDefault.integer(forKey: Keys.pageNumber)
    }
    
    func saveUser(_ username: String?) {
        userDefault.set(username, forKey: Keys.user)
    }
    
    func getUser() -> String? {
        return userDefault.string(forKey: Keys.user)
    }
    
    func saveSubject(_ subject: String?) {
        userDefault.set(subject, forKey: Keys.subject)
    }
    
    func getSubject() -> String? {
        return userDefault.string(forKey: Keys.subject)
    }
   
}
