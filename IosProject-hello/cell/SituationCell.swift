//
//  SituationCell.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/18/25.
//

import UIKit

class SituationCell: UICollectionViewCell {

    @IBOutlet weak var situationLabel: UILabel!
    private let backgroundCard = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardView()
        setupLabel()
    }

    func configure(with situation: Situation) {
        situationLabel.text = situation.description
    }

    private func setupCardView() {
        backgroundCard.backgroundColor = UIColor(hex: "#F0F0FF")
        backgroundCard.layer.cornerRadius = 12
        backgroundCard.layer.shadowColor = UIColor.black.cgColor
        backgroundCard.layer.shadowOpacity = 0.08
        backgroundCard.layer.shadowOffset = CGSize(width: 0, height: 1)
        backgroundCard.layer.shadowRadius = 4
        backgroundCard.translatesAutoresizingMaskIntoConstraints = false

        contentView.insertSubview(backgroundCard, at: 0)

        NSLayoutConstraint.activate([
            backgroundCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            backgroundCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            backgroundCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            backgroundCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6)
        ])
    }

    private func setupLabel() {
        situationLabel.numberOfLines = 0
        situationLabel.font = .systemFont(ofSize: 16, weight: .medium)
        situationLabel.textColor = .label
    }

    override var isSelected: Bool {
        didSet {
            backgroundCard.layer.borderWidth = isSelected ? 2 : 0
            backgroundCard.layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : nil
        }
    }
}
