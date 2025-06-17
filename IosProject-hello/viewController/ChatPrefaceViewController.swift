//
//  ChatPrefaceViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/18/25.
//
import UIKit

class ChatPrefaceViewController: UIViewController {

    // 입력값 전달용 클로저
    var onSubmit: ((_ nickname: String, _ situation: String) -> Void)?

    // nickname 입력창
    @IBOutlet weak var nicknameTextField: UITextField!
    // 상황 설명 입력창
    @IBOutlet weak var situationTextField: UITextField!
    // 제출 버튼
    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 기본 스타일 (옵션)
        nicknameTextField.placeholder = "어떻게 불리고 싶은가요? (예: 자기야)"
        situationTextField.placeholder = "어떤 상황인가요? (예: 첫 데이트 상황)"
    }

    @IBAction func submitTapped(_ sender: UIButton) {
        guard let nickname = nicknameTextField.text, !nickname.isEmpty,
              let situation = situationTextField.text, !situation.isEmpty else {
            return
        }

        dismiss(animated: true) {
            self.onSubmit?(nickname, situation)
        }
    }
}
