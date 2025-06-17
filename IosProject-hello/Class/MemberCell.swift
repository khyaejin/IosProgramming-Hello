//
//  MemberCell.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/17/25.
//

import UIKit

class MemberCell: UICollectionViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    func configure(with member: Member) {
        nameLabel.text = member.name
        // 이미지 URL이 있다면 나중에 로드
        avatarImageView.image = UIImage(named: "default_member") // 기본 이미지
    }
}
