//
//  SituationRepository.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/14/25.
//
// Firestore 저장/조회 로직

import FirebaseFirestore

class SituationRepository {
    private let reference = Firestore.firestore().collection("situations")

    func save(_ situation: Situation) {
        reference.document("\(situation.id)").setData(Situation.toDict(situation)) { error in
            if let error = error {
                print("❌ 저장 실패: \(error.localizedDescription)")
            } else {
                print("✅ 저장 완료")
            }
        }
    }

    func listenAll(onChange: @escaping ([Situation], DbAction) -> Void) {
        reference.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            for change in snapshot.documentChanges {
                guard let situation = Situation.fromDict(change.document.data()) else { continue }
                switch change.type {
                case .added: onChange([situation], .add)
                case .modified: onChange([situation], .modify)
                case .removed: onChange([situation], .delete)
                }
            }
        }
    }
}

enum DbAction {
    case add, modify, delete
}
