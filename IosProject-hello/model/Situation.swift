//
//  Situation.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/14/25.
//

import Foundation

struct Situation {
    var id: String
    var description: String

    static func toDict(_ situation: Situation) -> [String: Any] {
        return [
            "id": situation.id,
            "description": situation.description
        ]
    }

    static func fromDict(_ dict: [String: Any]) -> Situation? {
        guard let id = dict["id"] as? String,
              let description = dict["description"] as? String else {
            return nil
        }
        return Situation(id: id, description: description)
    }
}
