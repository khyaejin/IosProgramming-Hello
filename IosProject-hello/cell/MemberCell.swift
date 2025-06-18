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

    private let gradientBorderLayer = CAGradientLayer()
    private let shapeLayer = CAShapeLayer()

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
        // contentView: 카드 느낌
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true

        // 셀: 그림자
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false

        // 아바타 이미지 스타일
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true

        // 이름 라벨 스타일
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        nameLabel.textColor = .label
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 1

        // Gradient border 초기 설정
        gradientBorderLayer.colors = [
            UIColor.systemPurple.cgColor,
            UIColor.systemBlue.cgColor
        ]
        gradientBorderLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientBorderLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientBorderLayer.frame = avatarImageView.bounds

        let radius = min(avatarImageView.bounds.width, avatarImageView.bounds.height) / 2
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        gradientBorderLayer.mask = shapeLayer

        avatarImageView.layer.addSublayer(gradientBorderLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // 아바타를 1:1 비율의 원으로 유지
        let avatarSize = min(avatarImageView.bounds.width, avatarImageView.bounds.height)
        avatarImageView.layer.cornerRadius = avatarSize / 2

        // Gradient border 동기화
        gradientBorderLayer.frame = avatarImageView.bounds

        let radius = avatarSize / 2
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        shapeLayer.path = circularPath.cgPath
    }
}
