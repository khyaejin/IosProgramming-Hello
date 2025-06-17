//
//  Guide.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/14/25.
//

import Foundation

struct Guide {
    var id: String
    var situationId: String
    var content: String

    static func toDict(_ guide: Guide) -> [String: Any] {
        return [
            "id": guide.id,
            "situationId": guide.situationId,
            "content": guide.content
        ]
    }

    static func fromDict(_ dict: [String: Any]) -> Guide? {
        guard let id = dict["id"] as? String,
              let situationId = dict["situationId"] as? String,
              let content = dict["content"] as? String else {
            return nil
        }
        return Guide(id: id, situationId: situationId, content: content)
    }
}
