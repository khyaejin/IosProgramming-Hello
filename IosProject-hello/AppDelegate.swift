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
    let dataAddTest = DataAddTest()
    
    var window: UIWindow?
    
    // 로그인 후 저장될 사용자 정보
    var currentUser: User?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //firebase 연결
        FirebaseApp.configure()
        print(" FirebaseApp is configured: \(FirebaseApp.app() != nil)")

        
        // 데이터 삽입
//        dataAddTest.createTestMember()
//        dataAddTest.createTestSituation()
//        dataAddTest.createTestGuide()
        
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

