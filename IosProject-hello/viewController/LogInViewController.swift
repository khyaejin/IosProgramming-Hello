//
//  UserSettingViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/13/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LogInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
    }

    @IBAction func logInButtonTapped(_ sender: Any) {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            print("이메일과 비밀번호를 입력하세요.")
            return
        }

        // 1. Firebase Auth 로그인
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print("로그인 실패: \(error.localizedDescription)")
                return
            }

            guard let uid = result?.user.uid else { return }

            // 2. Firestore에서 사용자 정보 가져오기
            Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
                if let error = error {
                    print("사용자 정보 불러오기 실패: \(error.localizedDescription)")
                    return
                }

                guard let data = snapshot?.data(),
                      let user = User.fromDict(data) else {
                    print("사용자 데이터 파싱 실패")
                    return
                }

                print("로그인 성공. 사용자 이름: \(user.name)")

                // AppDelegate에 사용자 정보 저장
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.currentUser = user
                }

                self?.moveToMainScreen()
            }

        }
    }

    private func moveToMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarController
            }
        }
    }
}
