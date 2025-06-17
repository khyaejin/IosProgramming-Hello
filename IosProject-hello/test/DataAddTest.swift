//
//  DataAddTest.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/15/25.
//
import Foundation
import FirebaseFirestore

final class DataAddTest{
    func createTestMember() {
        let memberService = MemberService()

        let testMember = Member(
            id: "member002",
            userId: "user001",
            name: "김회원",
            age: 27,
            gender: "male",
            mbti: "ISFJ",
            tendency1: "배려형",
            tendency2: "진중한",
            tendency3: "성실한",
            characteristic: "듬직하고 배려심 깊음",
            nicknameForMe: "프롬프트",
            relationType: "연애",
            avatarURL: ""
        )

        // 중복 검사
        Firestore.firestore().collection("members").document(testMember.id).getDocument { doc, _ in
            if doc?.exists != true {
                memberService.createMember(member: testMember) { error in
                    print(error == nil ? " 멤버 생성 성공!" : " 멤버 생성 실패: \(error!.localizedDescription)")
                }
            } else {
                print("ℹ️ 이미 존재하는 멤버입니다.")
            }
        }

    }

    
    func testDatabase() {
        // MARK: - user
//        let userService = UserService()
        //        let user = User(id: "user001", name: "김혜진", age: 24, gender: "female", mbti: "INTP", tendency1: "감성적", tendency2: "외향적", tendency3: "개방적", loveType: "직진형")
        //
        //        userService.createUser(user: user) { error in
        //            print(error == nil ? "유저 생성 성공!" : "유저 생성 실패..: \(error!.localizedDescription)")
        //        }
        


        
        // MARK: - situation
//        let situationService = SituationService()
//        let situation = Situation(id: "situation001", description: "소개팅 첫 만남")
//        situationService.createSituation(situation: situation){ error in
//            print(error == nil ? "상황 생성 성공!" : "상황 생성 실패..: \(error!.localizedDescription)")
//        }
        
        
        // MARK: - guide
//        let guideService = GuideService()
//        let guide1 = Guide(id: "guide001", situationId: "situation001", content: "밝은 미소로 인사를 나눠보세요.")
//        let guide2 = Guide(id: "guide002", situationId: "situation001", content: "상대방의 말에 집중하고 리액션을 해주세요.")
//        let guide3 = Guide(id: "guide003", situationId: "situation001", content: "첫인상은 복장에서도 드러나요. 깔끔하게 입고 가세요.")
//        let guide4 = Guide(id: "guide004", situationId: "situation001", content: "무리한 자기 어필보다 자연스러운 대화가 좋아요.")
//        let guide5 = Guide(id: "guide005", situationId: "situation001", content: "긴장된다면 깊게 숨을 쉬고 천천히 말해보세요.")
//        guideService.createGuide(guide: guide1){ error in
//            print(error == nil ? "지침 생성 성공!" : "지침 생성 실패..: \(error!.localizedDescription)")
//        }
//        guideService.createGuide(guide: guide2){ error in
//            print(error == nil ? "지침 생성 성공!" : "지침 생성 실패..: \(error!.localizedDescription)")
//        }
//        guideService.createGuide(guide: guide3){ error in
//            print(error == nil ? "지침 생성 성공!" : "지침 생성 실패..: \(error!.localizedDescription)")
//        }
//        guideService.createGuide(guide: guide4){ error in
//            print(error == nil ? "지침 생성 성공!" : "지침 생성 실패..: \(error!.localizedDescription)")
//        }
//        guideService.createGuide(guide: guide5){ error in
//            print(error == nil ? "지침 생성 성공!" : "지침 생성 실패..: \(error!.localizedDescription)")
//        }
    }

}
