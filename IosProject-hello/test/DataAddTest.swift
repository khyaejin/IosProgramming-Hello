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
    
    // MARK: - situation
    func createTestSituation() {
        
        let situationService = SituationService()
        
        let situations: [Situation] = [
            Situation(id: "situation002", description: "연인이 약속을 자주 어길 때"),
            Situation(id: "situation003", description: "친구의 민감한 부탁을 거절하고 싶을 때"),
            Situation(id: "situation004", description: "같은 팀원이 계속 내 일까지 미룰 때"),
            Situation(id: "situation005", description: "회의 중 동료가 내 아이디어를 가로챘을 때"),
            Situation(id: "situation006", description: "상사에게 연차나 퇴근을 말 꺼내기 어려울 때"),
            Situation(id: "situation007", description: "후배에게 피드백을 잘 전달하고 싶을 때"),
            Situation(id: "situation008", description: "지인이 자꾸 사적인 부탁을 할 때"),
            Situation(id: "situation009", description: "부모님이 진로에 간섭할 때"),
            Situation(id: "situation010", description: "형제자매와 갈등이 심할 때"),
            Situation(id: "situation011", description: "중요한 회의나 업무 자리에서 신뢰감 있고 일 잘하는 사람처럼 보이고 싶을 때")

        ]
        
        for situation in situations {
            situationService.createSituation(situation: situation) { error in
                print(error == nil ? "'\(situation.description)' 저장 성공!" : "'\(situation.description)' 저장 실패: \(error!.localizedDescription)")
            }
        }
    }
    
    func createTestGuide(){
        let guideService = GuideService()

        // MARK: - guide
        let guides: [Guide] = [
//            Guide(id: "guide001", situationId: "situation001", content: "대화 도중 상대가 계속 웃기만 한다면 일단 멈춰라. 그것은 재미가 없다는 뜻이다."),
//            Guide(id: "guide002", situationId: "situation001", content: "무조건적인 공감은 하품을 유발한다. 적당한 주관과 본인의 색깔을 드러내라."),
//            Guide(id: "guide003", situationId: "situation001", content: "뻔한 얘기부터 해라. 대화는 부담스럽지 않은 TMI로부터 시작된다."),
//            Guide(id: "guide004", situationId: "situation001", content: "첫 만남에선 말보다 표정과 리액션이 기억에 더 남는다."),
//            Guide(id: "guide005", situationId: "situation001", content: "소개팅은 인터뷰가 아니다. 질문보다 교감을 더 많이 하라."),
//
//            Guide(id: "guide006", situationId: "situation002", content: "약속을 자주 어기는 건 신호일 수 있다. 감정을 묻기 전에, 상황을 먼저 물어봐라."),
//            Guide(id: "guide007", situationId: "situation002", content: "지적보다 감정 표현이 먼저다. '너 또 늦었네'보다 '난 좀 서운했어'가 낫다."),
//            Guide(id: "guide008", situationId: "situation002", content: "상습적인 약속 파기는 관계의 무게감 차이일 수 있다. 그 간극을 솔직하게 짚고 넘어가야 한다."),
//            Guide(id: "guide009", situationId: "situation002", content: "기대하지 않는다고 말하면, 상대도 마음을 놓는다. 진짜 원하는 게 뭔지 자신부터 점검하라."),
//            Guide(id: "guide010", situationId: "situation002", content: "책임을 물을 땐 정해진 기준을 공유하라. 상대는 네 머릿속 기준을 모른다."),
//
//            Guide(id: "guide011", situationId: "situation003", content: "친구의 부탁을 거절한다고 해서 관계가 끝나지 않는다. 오히려 건강한 경계가 시작된다."),
//            Guide(id: "guide012", situationId: "situation003", content: "거절은 이유보다 태도가 중요하다. 단호하되 미안해하지 말자."),
//            Guide(id: "guide013", situationId: "situation003", content: "불편한 부탁일수록 빠르게 대응하라. 시간을 끌수록 거절은 더 어려워진다."),
//            Guide(id: "guide014", situationId: "situation003", content: "‘네가 힘들 것 같아’는 상대의 감정을 배려하는 좋은 거절 문장이다."),
//            Guide(id: "guide015", situationId: "situation003", content: "가까운 사이일수록 ‘거절해도 괜찮다’는 훈련이 필요하다."),
//
//            Guide(id: "guide016", situationId: "situation004", content: "팀원이 내 일을 미룬다면, '기한'을 명확히 언급하라. 우선순위를 되짚는 방식이 효과적이다."),
//            Guide(id: "guide017", situationId: "situation004", content: "혼자 끙끙대지 마라. 반복되는 일이면 문서나 메신저로 공유해 기록을 남겨라."),
//            Guide(id: "guide018", situationId: "situation004", content: "'네가 힘들면 말해'는 책임 회피의 표현이다. 역할 분담은 말보다 시스템으로 하라."),
//            Guide(id: "guide019", situationId: "situation004", content: "도움과 의존은 다르다. 반복되는 미룸은 습관이다. 처음부터 선을 그어라."),
//            Guide(id: "guide020", situationId: "situation004", content: "일에 관한 대화는 사람 탓이 아니라 구조 이야기로 시작하라. 감정소모를 줄인다."),
//
//            Guide(id: "guide021", situationId: "situation005", content: "아이디어를 뺏겼다면, 논리보다 분위기를 점검하라. 타이밍이 핵심이다."),
//            Guide(id: "guide022", situationId: "situation005", content: "'제가 먼저 말씀드렸던 부분인데요'보다 '덧붙이자면'이 더 강력한 존재감을 남긴다."),
//            Guide(id: "guide023", situationId: "situation005", content: "아이디어를 도둑맞았을 땐, 다음 회의엔 슬라이드 하나라도 들고 가라. 눈에 보이게 해라."),
//            Guide(id: "guide024", situationId: "situation005", content: "아이디어를 되찾는 싸움이 아니라, 존재감을 확실히 각인시키는 싸움이라고 생각해라."),
//            Guide(id: "guide025", situationId: "situation005", content: "사소한 침묵은 침해를 키운다. 불편하더라도 당일 안에 감정을 표현하라."),
//            Guide(id: "guide026", situationId: "situation005", content: "내 아이디어라고 우기는 건 이기심처럼 보일 수 있다. 대신 팀워크 속에 이름을 남겨라."),
//            Guide(id: "guide027", situationId: "situation001", content: "말을 아끼는 사람이 더 신비로워 보인다. 말수보다 분위기를 관리하라."),
//            Guide(id: "guide028", situationId: "situation002", content: "약속을 어긴 상대에게 화내기 전, 당신도 과거에 비슷했던 적이 있었는지 돌아보라."),
//            Guide(id: "guide029", situationId: "situation003", content: "좋은 거절은 ‘관계는 유지하고, 상황은 거절하는 기술’이다."),
//            Guide(id: "guide030", situationId: "situation004", content: "‘그건 제 일이 아닌 것 같아요’보다, '업무 우선순위 조정이 필요할 것 같아요'가 효과적이다."),
//            Guide(id: "guide031", situationId: "situation011", content: "질문은 타이밍이다. 흐름을 끊지 말고, 핵심이 공유된 뒤에 던져라."),
//            Guide(id: "guide032", situationId: "situation011", content: "의견을 낼 땐 판단 기준을 먼저 말하라. '제 관점에선 ~라 판단했습니다'가 좋다."),
//            Guide(id: "guide033", situationId: "situation011", content: "애매한 말 대신 구체적 표현을 써라. '대략'보다 '2주 안팎'이 신뢰를 준다."),
//            Guide(id: "guide034", situationId: "situation011", content: "책임을 회피하는 말은 금물이다. '이건 제 생각일 뿐인데요...'는 신뢰를 깎는다."),
//            Guide(id: "guide035", situationId: "situation011", content: "의견 제시는 문제 해결형으로. '이건 좀 애매한데요'보다는 '이런 방식은 어떨까요?'가 낫다."),
//            Guide(id: "guide036", situationId: "situation011", content: "보고는 흐름과 구조다. 배경–현황–제안 순으로 요약해서 말하라."),
//            Guide(id: "guide037", situationId: "situation011", content: "확신이 없더라도 가능성을 열어라. '명확하진 않지만 이런 가능성은 있을 수 있습니다.'"),
//            Guide(id: "guide038", situationId: "situation011", content: "말끝을 흐리지 마라. '~이긴 한데...' 대신 '~라는 점에서 의견 드립니다'로 마무리하라."),
//            Guide(id: "guide039", situationId: "situation011", content: "주관 없이 말하면 묻힌다. 근거가 없어도 '제 기준에선 ~'으로 시작하라."),
//            Guide(id: "guide040", situationId: "situation011", content: "비판은 방향 제시와 함께. '이건 아닌 것 같습니다'보다 '이런 방식이 더 나아 보입니다'가 낫다.")
            Guide(id: "guide041", situationId: "situation001", content: "말을 천천히 해보라. 속도가 느릴수록 안정감 있고 신중한 인상을 준다."),
            Guide(id: "guide042", situationId: "situation001", content: "대화 시작은 자기 어려움 고백으로. '제가 낯가림이 좀 있어요'처럼 말하면 상대도 편해진다."),
            Guide(id: "guide043", situationId: "situation001", content: "'요즘 뭐에 빠져 있어요?'는 부담 없고 상대 취향을 자연스럽게 알아낼 수 있는 질문이다."),
            Guide(id: "guide044", situationId: "situation001", content: "유머를 준비하지 말고, 본인만의 이상한 포인트를 털어놔라. 이상하게 진심은 통한다."),
            Guide(id: "guide045", situationId: "situation001", content: "'소개팅에서 어색한 건 정상'이라는 프레임을 먼저 말하면 상대도 긴장을 푼다."),
            Guide(id: "guide046", situationId: "situation001", content: "말문이 막히면 질문으로 넘겨라. '그건 어떻게 생각하세요?'는 제일 무난한 리드 방법이다."),
            Guide(id: "guide047", situationId: "situation001", content: "상대 반응을 따라가라. 말이 길어지기 전에 상대 리액션을 보고 끊는 타이밍을 익혀야 한다.")


        ]

        guides.forEach {
            guideService.createGuide(guide: $0)
        }




    }

    
        // MARK: - user
//        let userService = UserService()
        //        let user = User(id: "user001", name: "김혜진", age: 24, gender: "female", mbti: "INTP", tendency1: "감성적", tendency2: "외향적", tendency3: "개방적", loveType: "직진형")
        //
        //        userService.createUser(user: user) { error in
        //            print(error == nil ? "유저 생성 성공!" : "유저 생성 실패..: \(error!.localizedDescription)")
        //        }
        


}
