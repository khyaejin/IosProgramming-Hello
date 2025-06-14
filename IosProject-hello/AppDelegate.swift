//
//  AppDelegate.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/13/25.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseFirestore
import FirebaseStorage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //firebase 연결
        FirebaseApp.configure()
        print("✅ FirebaseApp is configured: \(FirebaseApp.app() != nil)")

        let db = Firestore.firestore()

        // 간단한 테스트용 회원 정보 저장
        db.collection("users").document("testUser01").setData([
            "name": "테스트용 유저",
            "age": 20,
            "gender": "female",
            "mbti": "ENFP"
        ]) { error in
            if let error = error {
                print("🔥 저장 실패: \(error.localizedDescription)")
            } else {
                print("✅ 저장 성공: testUser01")
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

