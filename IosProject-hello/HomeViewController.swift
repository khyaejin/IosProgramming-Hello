//
//  ViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/13/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let repo = SituationRepository()

        
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white

                // 저장 테스트
                let situation = Situation(id: 1, situation: "첫 만남에서 긴장될 때")
                repo.save(situation)

                // 변경 감지 테스트
                repo.listenAll { situations, action in
                    for s in situations {
                        print("📢 \(action): \(s)")
                    }
                }
    }
}

