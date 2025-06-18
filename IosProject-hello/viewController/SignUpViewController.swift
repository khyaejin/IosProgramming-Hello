//
//  UserSettingViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/13/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var genderPick: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
    }

    @IBAction func SignUpButton(_ sender: Any) {
        guard let name = nameField.text, !name.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            print("모든 필드를 입력해야 합니다.")
            return
        }

        let gender = genderPick.selectedSegmentIndex == 0 ? "여자" : "남자"

        // 1. FirebaseAuth에 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("회원가입 실패: \(error.localizedDescription)")
                print("에러 전체: \(error)")
                return
            }

            guard let uid = result?.user.uid else { return }

            // 2. User 객체 생성
            let newUser = User(id: uid, name: name, email: email, password: password, gender: gender)

            // 3. Firestore에 저장
            let userDict = User.toDict(newUser)
            Firestore.firestore().collection("users").document(uid).setData(userDict) { error in
                if let error = error {
                    print("Firestore 저장 실패: \(error.localizedDescription)")
                } else {
                    print("사용자 정보 저장 완료")
                    self.moveToLoginScreen()
                }
            }
        }
    }

    private func moveToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = loginVC
            }
        }
    }
}
