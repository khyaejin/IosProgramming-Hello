//
//  SituationCell.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/18/25.
//

import UIKit

class SituationCell: UICollectionViewCell {
    @IBOutlet weak var situationLabel: UILabel!

    func configure(with situation: Situation) {
        situationLabel.text = situation.description
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        situationLabel.numberOfLines = 0
        situationLabel.font = .systemFont(ofSize: 16, weight: .medium)
        situationLabel.textColor = .label
    }
//    override var isSelected: Bool {
//        didSet {
//            contentView.backgroundColor = isSelected ? UIColor.systemGray5 : UIColor.clear
//        }
//    }
}
