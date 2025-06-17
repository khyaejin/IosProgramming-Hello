//
//  SituationService.swift
//  IosProject-hello
//
//  Created by 김혜진 on 2025/06/14.
//

import Foundation
import FirebaseFirestore

final class SituationService {
    private let db = Firestore.firestore()
    private let collection = "situations"

    // 상황 하나 저장
    func createSituation(situation: Situation, completion: ((Error?) -> Void)? = nil) {
        let data = Situation.toDict(situation)
        db.collection(collection).document(situation.id).setData(data) { error in
            completion?(error)
        }
    }

    // 모든 상황 불러오기
    func fetchAllSituations(completion: @escaping ([Situation]) -> Void) {
        db.collection(collection).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                print("❌ 상황 불러오기 실패: \(error?.localizedDescription ?? "알 수 없음")")
                completion([])
                return
            }

            let situations = documents.compactMap { doc in
                Situation.fromDict(doc.data())
            }
            completion(situations)
        }
    }
}
