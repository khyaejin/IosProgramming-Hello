//
//  Member.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/14/25.
//

import Foundation

struct Member {
    var id: String
    var userId: String // 이 멤버가 연결된 사용자
    var name: String
    var age: Int
    var gender: String
    var mbti: String
    var tendency1: String
    var tendency2: String
    var tendency3: String
    var loveType: String
    var prompt: String
    var relationType: String // 관계의 성격 (ex. 썸, 친구, 짝사랑)

    static func toDict(_ member: Member) -> [String: Any] {
        return [
            "id": member.id,
            "userId": member.userId,
            "name": member.name,
            "age": member.age,
            "gender": member.gender,
            "mbti": member.mbti,
            "tendency1": member.tendency1,
            "tendency2": member.tendency2,
            "tendency3": member.tendency3,
            "loveType": member.loveType,
            "prompt": member.prompt,
            "relationType": member.relationType
        ]
    }

    static func fromDict(_ dict: [String: Any]) -> Member? {
        guard let id = dict["id"] as? String,
              let userId = dict["userId"] as? String,
              let name = dict["name"] as? String,
              let age = dict["age"] as? Int,
              let gender = dict["gender"] as? String,
              let mbti = dict["mbti"] as? String,
              let tendency1 = dict["tendency1"] as? String,
              let tendency2 = dict["tendency2"] as? String,
              let tendency3 = dict["tendency3"] as? String,
              let loveType = dict["loveType"] as? String,
              let prompt = dict["prompt"] as? String,
              let relationType = dict["relationType"] as? String else {
            return nil
        }
        return Member(id: id, userId: userId, name: name, age: age, gender: gender, mbti: mbti, tendency1: tendency1, tendency2: tendency2, tendency3: tendency3, loveType: loveType, prompt: prompt, relationType: relationType)
    }
}
