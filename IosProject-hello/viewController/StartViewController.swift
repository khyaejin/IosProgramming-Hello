//
//  LoginViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/13/25.
//

import UIKit

class StartViewController: UIViewController {

    @IBAction func logInButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let userSettingVC = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController {
            self.present(userSettingVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func SignUpButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let userSettingVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            self.present(userSettingVC, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

