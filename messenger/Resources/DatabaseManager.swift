//
//  DatabaseManager.swift
//  messenger
//
//  Created by Matthew Bell on 12/28/20.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
}

// MARK: - Account Management

extension DatabaseManager {
    
    public func userExists(with email: String,
                           completion: @escaping ((Bool) -> Void)) {
        
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
        
    }
    
    /// Inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAdress).setValue([
            "first_name": user.fisrtName,
            "last_name": user.lastName
        ])
    }
}

struct ChatAppUser {
    let fisrtName: String
    let lastName: String
    let emailAdress: String
 //   let profilePictureUrl: String
}
