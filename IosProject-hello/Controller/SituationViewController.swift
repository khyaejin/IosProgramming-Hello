//
//  SituationViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/14/25.
//
// 테스트 및 연동 컨트롤러

import UIKit

class SituationViewController: UIViewController {
    let repo = SituationRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // 🔹 저장 테스트
        let test = Situation(id: 1, situation: "소개팅에서 긴장될 때")
        repo.save(test)

        // 🔹 조회 테스트
        repo.listenAll { situations, action in
            for s in situations {
                print("📦 (\(action)) 상황: \(s)")
            }
        }
    }
}
