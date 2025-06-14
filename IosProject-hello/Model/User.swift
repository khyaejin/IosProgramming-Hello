//
//  User.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/14/25.
//

import Foundation

struct User {
    var id: Int
    var name: String
    var age: Int
    var gender: String
    var mbti: String
    var tendency1: String
    var tendency2: String
    var tendency3: String
    var loveType: String

    static func toDict(_ user: User) -> [String: Any] {
        return [
            "id": user.id,
            "name": user.name,
            "age": user.age,
            "gender": user.gender,
            "mbti": user.mbti,
            "tendency1": user.tendency1,
            "tendency2": user.tendency2,
            "tendency3": user.tendency3,
            "love_type": user.loveType
        ]
    }

    static func fromDict(_ dict: [String: Any]) -> User? {
        guard let id = dict["id"] as? Int,
              let name = dict["name"] as? String,
              let age = dict["age"] as? Int,
              let gender = dict["gender"] as? String,
              let mbti = dict["mbti"] as? String,
              let tendency1 = dict["tendency1"] as? String,
              let tendency2 = dict["tendency2"] as? String,
              let tendency3 = dict["tendency3"] as? String,
              let loveType = dict["love_type"] as? String else {
            return nil
        }
        return User(id: id, name: name, age: age, gender: gender, mbti: mbti, tendency1: tendency1, tendency2: tendency2, tendency3: tendency3, loveType: loveType)
    }
}
