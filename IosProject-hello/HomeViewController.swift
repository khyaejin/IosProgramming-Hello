//
//  ViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/13/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // 테스트 코드 실행
//        testCreateUserAndMemberAndSituation()
    }
    
    
    
    func testCreateUserAndMemberAndSituation() {
        let userService = UserService()
        let memberService = MemberService()
        let situationService = SituationService()

        let user = User(id: "user001", name: "김혜진", age: 24, gender: "female", mbti: "INTP", tendency1: "감성적", tendency2: "외향적", tendency3: "개방적", loveType: "직진형")

        let member = Member(id: "member001", userId: "user001", name: "김회원", age: 27, gender: "male", mbti: "ISFJ", tendency1: "배려형", tendency2: "진중한", tendency3: "성실한", loveType: "소극적", prompt: "프롬프트", relationType: "연애")
        
        let situation = Situation(id: "situation001", description: "소개팅 첫만남")

        userService.createUser(user: user) { error in
            print(error == nil ? "유저 생성 성공" : "유저 생성 실패: \(error!.localizedDescription)")
        }

        memberService.createMember(member: member) { error in
            print(error == nil ? "멤버 생성 성공" : "멤버 생성 실패: \(error!.localizedDescription)")
        }
        
        situationService.createSituation(situation: situation){ error in
            print(error == nil ? "상황 생성 성공" : "상황 생성 실패: \(error!.localizedDescription)")
        }
    }

}

