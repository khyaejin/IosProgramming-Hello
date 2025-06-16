//
//  MemberSettingViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/13/25.
//

import UIKit

class MemberSettingViewController: UIViewController {

    weak var delegate: MemberSettingDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // 화면 로드 시 로직
    }

    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.memberDidFinishSetting()  // HomeViewController에 알려줌
        dismiss(animated: true, completion: nil)
    }
}


protocol MemberSettingDelegate: AnyObject {
    func memberDidFinishSetting()
}

