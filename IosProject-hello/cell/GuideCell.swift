//
//  GuideCell.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/18/25.
//

import UIKit

class GuideCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    private let cardView = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

        setupCardView()
        setupContentLabel()
        applyAppearAnimation()
    }

    private func setupCardView() {
        // 카드 스타일 적용
        cardView.backgroundColor = UIColor(hex: "#F0F0FF") // 연한 파란 배경
        cardView.layer.cornerRadius = 16 // 더 둥글게
        cardView.layer.masksToBounds = false

        // 그림자 효과
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 6

        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.insertSubview(cardView, at: 0)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    private func setupContentLabel() {
        contentLabel.numberOfLines = 0
        contentLabel.font = .systemFont(ofSize: 16)
        contentLabel.textColor = .label
    }

    private func applyAppearAnimation() {
        cardView.alpha = 0
        UIView.animate(withDuration: 0.35, delay: 0, options: [.curveEaseOut]) {
            self.cardView.alpha = 1
        }
    }

    func configure(with guide: Guide) {
        contentLabel.text = guide.content
    }
}
