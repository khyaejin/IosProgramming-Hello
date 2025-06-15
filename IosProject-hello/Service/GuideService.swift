//
//  GuideService.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/15/25.
//
import Foundation
import FirebaseFirestore

final class GuideService {
    private let db = Firestore.firestore()
    private let collection = "guides"
    
    // 지침 만들기
    func createGuide(guide: Guide, completion: ((Error?) -> Void)? = nil) {
        let data = Guide.toDict(guide)
        db.collection(collection).document(guide.id).setData(data) { error in
            completion?(error)
        }
    }
    
    // 특정 상황 ID에 해당하는 지침들 불러오기
    func fetchGuides(for situationId: String, completion: @escaping ([Guide]) -> Void) {
        db.collection(collection)
            .whereField("situationId", isEqualTo: situationId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("지침 불러오기 실패: \(error.localizedDescription)")
                    completion([])
                    return
                }

                guard let documents = snapshot?.documents else {
                    completion([])
                    return
                }

                let guides = documents.compactMap { doc in
                    Guide.fromDict(doc.data())
                }
                completion(guides)
            }
    }
}
