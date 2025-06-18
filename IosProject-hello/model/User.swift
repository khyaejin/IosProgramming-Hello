//
//  User.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/14/25.
//

import Foundation

struct User {
    var id: String
    var name: String
    var email: String
    var password: String
    var gender: String

    static func toDict(_ user: User) -> [String: Any] {
            return [
                "id": user.id,
                "name": user.name,
                "email": user.email,
                "gender": user.gender
            ]
    }

    static func fromDict(_ dict: [String: Any]) -> User? {
            guard let id = dict["id"] as? String,
                  let name = dict["name"] as? String,
                  let email = dict["email"] as? String,
                  let gender = dict["gender"] as? String else {
                return nil
            }
            // 비밀번호는 보통 Firestore에 저장하지 않음
            return User(id: id, name: name, email: email, password: "", gender: gender)
    }
    
}
