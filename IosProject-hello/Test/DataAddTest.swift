//
//  DataAddTest.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/15/25.
//
import Foundation

final class DataAddTest{
    func testDatabase() {
        let userService = UserService()
        let memberService = MemberService()
        let situationService = SituationService()
        let guideService = GuideService()

        let user = User(id: "user001", name: "김혜진", age: 24, gender: "female", mbti: "INTP", tendency1: "감성적", tendency2: "외향적", tendency3: "개방적", loveType: "직진형")

        let member = Member(id: "member001", userId: "user001", name: "김회원", age: 27, gender: "male", mbti: "ISFJ", tendency1: "배려형", tendency2: "진중한", tendency3: "성실한", loveType: "소극적", prompt: "프롬프트", relationType: "연애")
        
        let situation = Situation(id: "situation001", description: "소개팅 첫 만남")

        let guide1 = Guide(id: "guide001", situationId: "situation001", content: "밝은 미소로 인사를 나눠보세요.")
        let guide2 = Guide(id: "guide002", situationId: "situation001", content: "상대방의 말에 집중하고 리액션을 해주세요.")
        let guide3 = Guide(id: "guide003", situationId: "situation001", content: "첫인상은 복장에서도 드러나요. 깔끔하게 입고 가세요.")
        let guide4 = Guide(id: "guide004", situationId: "situation001", content: "무리한 자기 어필보다 자연스러운 대화가 좋아요.")
        let guide5 = Guide(id: "guide005", situationId: "situation001", content: "긴장된다면 깊게 숨을 쉬고 천천히 말해보세요.")

        userService.createUser(user: user) { error in
            print(error == nil ? "유저 생성 성공!" : "유저 생성 실패..: \(error!.localizedDescription)")
        }

        memberService.createMember(member: member) { error in
            print(error == nil ? "멤버 생성 성공!" : "멤버 생성 실패..: \(error!.localizedDescription)")
        }
        
        situationService.createSituation(situation: situation){ error in
            print(error == nil ? "상황 생성 성공!" : "상황 생성 실패..: \(error!.localizedDescription)")
        }
        guideService.createGuide(guide: guide1){ error in
            print(error == nil ? "지침 생성 성공!" : "지침 생성 실패..: \(error!.localizedDescription)")
        }
        guideService.createGuide(guide: guide2){ error in
            print(error == nil ? "지침 생성 성공!" : "지침 생성 실패..: \(error!.localizedDescription)")
        }
        guideService.createGuide(guide: guide3){ error in
            print(error == nil ? "지침 생성 성공!" : "지침 생성 실패..: \(error!.localizedDescription)")
        }
        guideService.createGuide(guide: guide4){ error in
            print(error == nil ? "지침 생성 성공!" : "지침 생성 실패..: \(error!.localizedDescription)")
        }
        guideService.createGuide(guide: guide5){ error in
            print(error == nil ? "지침 생성 성공!" : "지침 생성 실패..: \(error!.localizedDescription)")
        }
    }

}
