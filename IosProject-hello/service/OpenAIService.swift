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
            "model": "gpt-4.1-nano",
            "messages": messageHistory,
            "temperature": 0.8
        ]

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        print("== OpenAI 요청 시작 ==")
        print("== API Key 길이: \(apiKey.count) | 비어있는지: \(apiKey.isEmpty)")
        print("== Request Payload:")
        if let payloadData = try? JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted),
           let payloadString = String(data: payloadData, encoding: .utf8) {
            print(payloadString)
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("== 요청 에러: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("== 응답 코드: \(httpResponse.statusCode)")
            }

            guard let data = data else {
                print("== 응답 데이터 없음")
                completion(nil)
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                print("== 응답 본문:\n\(responseString)")
            }

            // 파싱 시도
            if let result = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = result["choices"] as? [[String: Any]],
               let message = choices.first?["message"] as? [String: Any],
               let content = message["content"] as? String {
                completion(content)
            } else {
                print("== 응답 파싱 실패\n응답 내용: \(String(data: data, encoding: .utf8) ?? "없음")")
                completion(nil)
            }

        }.resume()
    }
}
