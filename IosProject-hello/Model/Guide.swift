//
//  Guide.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/14/25.
//

import Foundation

struct Guide {
    var id: Int
    var situationId: Int
    var content: String

    static func toDict(_ guide: Guide) -> [String: Any] {
        return [
            "id": guide.id,
            "situation_id": guide.situationId,
            "content": guide.content
        ]
    }

    static func fromDict(_ dict: [String: Any]) -> Guide? {
        guard let id = dict["id"] as? Int,
              let situationId = dict["situation_id"] as? Int,
              let content = dict["content"] as? String else {
            return nil
        }
        return Guide(id: id, situationId: situationId, content: content)
    }
}
