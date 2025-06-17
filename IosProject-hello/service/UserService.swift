//
//  UserService.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/14/25.
//
import Foundation
import FirebaseFirestore

final class UserService {
    private let db = Firestore.firestore()
    private let collection = "users"

    func createUser(user: User, completion: ((Error?) -> Void)? = nil) {
        let data = User.toDict(user)
        db.collection(collection).document(user.id).setData(data) { error in
            completion?(error)
        }
    }
}
