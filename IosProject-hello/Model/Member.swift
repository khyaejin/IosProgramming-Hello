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
    var name: String // 닉네임
    var age: Int
    var gender: String
    var mbti: String
    var tendency1: String
    var tendency2: String
    var tendency3: String
    var characteristic: String // 특징
    var prompt: String // 상황에 따른 프롬프트
    var relationType: String // 관계의 성격 (ex. 연인, 친구, 가족, 선배, 상사 등)
    var avatarURL: String // Storage에 저장된 이미지 경로

    // Firestore에 저장하기 위한 Dictionary 변환
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
            "characteristic": member.characteristic,
            "prompt": member.prompt,
            "relationType": member.relationType,
            "avatarURL": member.avatarURL
        ]
    }

    // Firestore에서 받아온 Dictionary를 Member로 변환
    static func fromDict(_ dict: [String: Any]) -> Member? {
        let id = dict["id"] as? String ?? ""
        let userId = dict["userId"] as? String ?? ""
        let name = dict["name"] as? String ?? ""
        let age = dict["age"] as? Int ?? 0
        let gender = dict["gender"] as? String ?? ""
        let mbti = dict["mbti"] as? String ?? ""
        let tendency1 = dict["tendency1"] as? String ?? ""
        let tendency2 = dict["tendency2"] as? String ?? ""
        let tendency3 = dict["tendency3"] as? String ?? ""
        let characteristic = dict["characteristic"] as? String ?? ""
        let prompt = dict["prompt"] as? String ?? ""
        let relationType = dict["relationType"] as? String ?? ""
        let avatarURL = dict["avatarURL"] as? String ?? ""

        return Member(
            id: id,
            userId: userId,
            name: name,
            age: age,
            gender: gender,
            mbti: mbti,
            tendency1: tendency1,
            tendency2: tendency2,
            tendency3: tendency3,
            characteristic: characteristic,
            prompt: prompt,
            relationType: relationType,
            avatarURL: avatarURL
        )
    }

}
