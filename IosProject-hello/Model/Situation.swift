//
//  Situation.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/14/25.
//
// 모델 구조체 + 딕셔너리 변환

import Foundation

struct Situation {
    var id: Int
    var situation: String

    static func toDict(_ situation: Situation) -> [String: Any] {
        return [
            "id": situation.id,
            "situation": situation.situation
        ]
    }

    static func fromDict(_ dict: [String: Any]) -> Situation? {
        guard let id = dict["id"] as? Int,
              let situation = dict["situation"] as? String else {
            return nil
        }
        return Situation(id: id, situation: situation)
    }
}
