//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Gabriel de Castro Chaves on 18/06/23.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
}

//MARK: Account Management
extension DatabaseManager {
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
                                                 
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAddress).setValue([
            "firstName" : user.firstName,
            "lastName" : user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    //let profilePictureUrl: String
}

