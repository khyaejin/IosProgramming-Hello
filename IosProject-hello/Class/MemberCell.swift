//
//  MemberCell.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/17/25.
//

import UIKit
import SDWebImage  // 이미지 로딩 라이브러리 사용 추천

class MemberCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    func configure(with member: Member) {
        nameLabel.text = member.name

        // Firebase Storage에서 가져온 avatarURL로 이미지 로드
        if let url = URL(string: member.avatarURL) {
            avatarImageView.sd_setImage(with: url)
        } else {
            avatarImageView.image = UIImage(named: "default_member")
        }
    }
}

