//
//  MemberCell.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/17/25.
//
import UIKit
import SDWebImage

class MemberCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }

    func configure(with member: Member) {
        nameLabel.text = member.name

        if let url = URL(string: member.avatarURL) {
            avatarImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "default_member"))
        } else {
            avatarImageView.image = UIImage(named: "default_member")
        }
    }

    private func setupStyle() {
        // 카드 느낌의 contentView 스타일
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white

        // 셀 자체에 그림자
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
        layer.masksToBounds = false

        // 아바타 이미지 스타일
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.systemGray4.cgColor

        // 이름 라벨 스타일
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        nameLabel.textColor = UIColor.darkGray
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    }
}
