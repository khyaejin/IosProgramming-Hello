//
//  OpenAIService.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/18/25.
//

import Foundation

class OpenAIService {

    private let apiKey = KeyManager.shared.get("OPENAI_API_KEY")
    private let endpoint = URL(string: "https://api.openai.com/v1/chat/completions")!

    func sendChat(messages: [Message], systemPrompt: String, userInput: String, completion: @escaping (String?) -> Void) {
        let messageHistory: [[String: String]] = [
            ["role": "system", "content": systemPrompt]
        ] + messages.map {
            [
                "role": $0.isUser ? "user" : "assistant",
                "content": $0.text
            ]
        } + [["role": "user", "content": userInput]]

        let payload: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messageHistory,
            "temperature": 0.8
        ]

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let result = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = result["choices"] as? [[String: Any]],
                  let message = choices.first?["message"] as? [String: String],
                  let content = message["content"] else {
                completion(nil)
                return
            }
            completion(content)
        }.resume()
    }
}
