//
//  MemberService.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/14/25.
//
import Foundation
import FirebaseFirestore

final class MemberService {
    private let db = Firestore.firestore()
    private let collection = "members"

    func createMember(member: Member, completion: ((Error?) -> Void)? = nil) {
        let data = Member.toDict(member)
        db.collection(collection).document(member.id).setData(data) { error in
            completion?(error)
        }
    }
}
