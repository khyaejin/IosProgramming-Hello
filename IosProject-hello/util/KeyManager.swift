//
//  KeyManager.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/18/25.
//

import Foundation

class KeyManager {
    static let shared = KeyManager()

    private var keys: [String: Any] = [:]

    private init() {
        if let url = Bundle.main.url(forResource: "OpenAI-Keys", withExtension: "plist"),
           let data = try? Data(contentsOf: url),
           let dict = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] {
            keys = dict
        }
    }

    func get(_ key: String) -> String {
        return keys[key] as? String ?? ""
    }
}
